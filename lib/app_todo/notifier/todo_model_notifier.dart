import 'package:flutter22_sample/app_todo/custom_exception.dart';
import 'package:flutter22_sample/app_todo/model/todo_model.dart';
import 'package:flutter22_sample/app_todo/repository/todo_model_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final todoListExceptionProvider = StateProvider<CustomException?>((_) => null);

// todo-model for update
final todoModelProvider = StateProvider<TodoModel>((ref) => const TodoModel());

// TodoList-NotifierProvider
final todoListNotifierProvider =
    StateNotifierProvider<TodoListStateNotifier, AsyncValue<List<TodoModel>>>(
  (ref) => TodoListStateNotifier(ref.read),
);

// TagList-StateProvider
final tagListStateProvider = StateProvider<List<String>>((_) => []);

// Filtered-TodoList-Provider
final Provider<List<TodoModel>> filteredTodoListProvider =
    Provider<List<TodoModel>>((ref) {
  // 依存するProviderを取得
  final todoListAV = ref.watch(todoListNotifierProvider);
  final tagListState = ref.watch(tagListStateProvider).state;

  // 絞込条件後のリストを返却
  todoListAV.maybeWhen(
    data: (items) {
      if (tagListState.isNotEmpty) {
        //return items.where((item) => false).toList();
        return items.sublist(0, 1);
      } else {
        return <TodoModel>[];
      }
    },
    orElse: () => <TodoModel>[],
  );
  return <TodoModel>[];
});

// TodoListの状態管理
class TodoListStateNotifier extends StateNotifier<AsyncValue<List<TodoModel>>> {
  TodoListStateNotifier(this._read) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  final Reader _read;

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      final items = await _read(todoRepositoryProvider).retrieveItems();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createItem(TodoModel item) async {
    try {
      final dtoItem =
          item.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now());
      await _read(todoRepositoryProvider).createItem(item: dtoItem);
      await retrieveItems();
    } on CustomException catch (e) {
      _read(todoListExceptionProvider).state = e;
    }
  }

  Future<void> updateItem(TodoModel item) async {
    try {
      final dtoItem = item.copyWith(updatedAt: DateTime.now());
      await _read(todoRepositoryProvider).updateItem(item: dtoItem);
      await retrieveItems();
    } on CustomException catch (e) {
      _read(todoListExceptionProvider).state = e;
    }
  }

  List<String> getTagList() {
    final tagSet = <String>{};
    state.whenData((items) {
      for (final item in items) {
        tagSet.addAll(item.tags ?? []);
      }
    });
    return tagSet.toList(); //.sort((a,b) => a.compareTo(b));
  }
}

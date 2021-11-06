import 'package:flutter22_sample/app_todo/custom_exception.dart';
import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter22_sample/app_todo/repository/todo_item_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final todoListExceptionProvider = StateProvider<CustomException?>((_) => null);

// TodoList-NotifierProvider
final todoListNotifierProvider =
    StateNotifierProvider<TodoListStateNotifier, AsyncValue<List<TodoItem>>>(
  (ref) => TodoListStateNotifier(ref.read),
);

// TagList-StateProvider
final tagListStateProvider = StateProvider<List<String>>((_) => []);

// Filtered-TodoList-Provider
final Provider<List<TodoItem>> filteredTodoListProvider =
    Provider<List<TodoItem>>((ref) {
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
        return <TodoItem>[];
      }
    },
    orElse: () => <TodoItem>[],
  );
  return <TodoItem>[];
});

// TodoListの状態管理
class TodoListStateNotifier extends StateNotifier<AsyncValue<List<TodoItem>>> {
  TodoListStateNotifier(this._read) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  final Reader _read;

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      final items = await _read(todoItemRepositoryProvider).retrieveItems();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createItem(TodoItem item) async {
    try {
      final dtoItem =
          item.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now());
      await _read(todoItemRepositoryProvider).createItem(item: dtoItem);
      await retrieveItems();
    } on CustomException catch (e) {
      _read(todoListExceptionProvider).state = e;
    }
  }

  Future<void> updateItem(TodoItem item) async {
    try {
      final dtoItem = item.copyWith(updatedAt: DateTime.now());
      await _read(todoItemRepositoryProvider).updateItem(item: dtoItem);
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

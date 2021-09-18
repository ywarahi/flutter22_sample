import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'custom_exception.dart';
import 'model/todo_model.dart';
import 'todo_repository.dart';

final todoListExceptionProvider = StateProvider<CustomException?>((_) => null);

// TodoList-NotifierProvider
final todoListNotifierProvider =
    StateNotifierProvider<TodoListStateNotifier, AsyncValue<List<TodoModel>>>(
  (ref) => TodoListStateNotifier(ref.read),
);

// tagList-StateProvider
final tagListStateProvider = StateProvider<List<String>>((_) => []);

// Filtered-TodoList-Provider
final Provider<List<TodoModel>> FilteredTodoListProvider =
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

  Future<void> add(String title) async {
    try {
      final dtoItem = TodoModel(
          title: title, createdAt: DateTime.now(), updatedAt: DateTime.now());
      final newItem =
          await _read(todoRepositoryProvider).createItem(item: dtoItem);
      state.whenData((items) => state = AsyncValue.data(items..add(newItem)));
    } on CustomException catch (e) {
      _read(todoListExceptionProvider).state = e;
    }
  }

  List<String> getTagList() {
    var tagSet = <String>{};
    state.whenData((items) {
      for (final item in items) {
        tagSet.addAll(item.tags?? []);
      }
    });
    return tagSet.toList(); //.sort((a,b) => a.compareTo(b));
  }
}

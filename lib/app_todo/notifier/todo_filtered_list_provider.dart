import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_list_sn_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

// TagList-StateProvider
final tagListStateProvider = StateProvider<List<String>>((_) => []);

// Filtered-TodoList-Provider
final Provider<List<TodoItem>> filteredTodoListProvider =
    Provider<List<TodoItem>>((ref) {
  // 依存するProviderを取得
  final todoListAV = ref.watch(todoListSNProvider);
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

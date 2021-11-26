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
  final todoList = ref.watch(todoListSNProvider);
  final tagList = ref.watch(tagListStateProvider).state;

  // 絞込条件後のリストを返却
  if (tagList.isNotEmpty) {
    return todoList.where((item) {
      for (var tag in item.tags ?? <String>[]) {
        if (tagList.contains(tag)) {
          return true;
        }
      }
      return false;
    }).toList();
  } else {
    return <TodoItem>[];
  }
});

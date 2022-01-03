import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_item_update_provider.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_list_sn_provider.dart';
import 'package:flutter22_sample/app_todo/page/todo_update_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final currentIndexItem =
    ScopedProvider<TodoItem>((watch) => throw UnimplementedError());

class TodoListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // get-provider
    final todoList = watch(todoListSNProvider);

    // build-flutter_widget
    return todoList.isNotEmpty
        ? ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return ProviderScope(
                overrides: [
                  currentIndexItem.overrideWithValue(todoList[index])
                ],
                child: const TodoItemView(),
              );
            })
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

class TodoItemView extends ConsumerWidget {
  const TodoItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final item = watch(currentIndexItem);
    return GestureDetector(
      onTap: () {
        watch(todoItemUpdateProvider).state = item;
        Navigator.of(context).push(TodoUpdateDialog());
        //Navigator.of(context).pushNamed('/regist');
      },
      child: ListTile(title: Text(item.title ?? 'NO-TITLE')),
    );
  }
}

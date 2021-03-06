import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_item_update_provider.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_list_sn_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final currentIndexItem =
    ScopedProvider<TodoItem>((watch) => throw UnimplementedError());

class TodoListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // get-provider
    final todoList = watch(todoListSNProvider);
    //final tagList = watch(todoListNotifierProvider.notifier).getTagList();

    // build-flutter_widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo ListView'),
      ),
      body: todoList.isNotEmpty
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
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // watch(todoItemProvider).state = const TodoItem(tags: ['DEFAULT']);
          // Navigator.of(context).pushNamed('/regist');

          Navigator.of(context).pushNamed('/search');
        },
        child: const Icon(Icons.add),
      ),
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
        Navigator.of(context).pushNamed('/regist');
      },
      child: ListTile(title: Text(item.title ?? 'NO-TITLE')),
    );
  }
}

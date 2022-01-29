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
    final todoItem = context.read(todoItemUpdateProvider);

    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GestureDetector(
          onTap: () {
            todoItem.state = const TodoItem(tags: ['DEFAULT']);
            Navigator.of(context).push(TodoUpdateDialog());
          },
          child: const Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text('追加'),
              subtitle: Text('itemを追加します'),
              tileColor: Colors.greenAccent,
            ),
          ),
        ),
      ),
      // SizedBox(
      //     width: double.infinity,
      //     child: ElevatedButton(
      //       child: const Text('追加'),
      //         style: ElevatedButton.styleFrom(
      //           // primary: Colors.blue,
      //           // onPrimary: Colors.black,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(15),
      //           ),),
      //       onPressed: () {
      //         watch(todoItemUpdateProvider).state = TodoItem();
      //         Navigator.of(context).push(TodoUpdateDialog());
      //       },
      //     )),
      Expanded(
          child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ProviderScope(
            overrides: [currentIndexItem.overrideWithValue(todoList[index])],
            child: const TodoItemView(),
          );
        },
      ))
    ]);
  }
}

class TodoItemView extends ConsumerWidget {
  const TodoItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final item = watch(currentIndexItem);
    final todoItem = watch(todoItemUpdateProvider);

    return GestureDetector(
        onTap: () {
          todoItem.state = item;
          Navigator.of(context).push(TodoUpdateDialog());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
          child: Card(
              color: Colors.white,
              child: ListTile(
                title: Text(item.title ?? 'NO-TITLE'),
                subtitle: Text(item.description ?? 'NO-DESCRIPTION'),
                tileColor: Colors.limeAccent,
                trailing: const Icon(Icons.more_vert),
                //contentPadding: const EdgeInsets.all(20),
              )),
        ));
  }
}

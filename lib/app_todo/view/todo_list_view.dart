import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_item_notifier.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final currentIndexItem =
    ScopedProvider<TodoItem>((watch) => throw UnimplementedError());

class TodoListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // get-provider
    final todoListAV = watch(todoListNotifierProvider);
    //final tagList = watch(todoListNotifierProvider.notifier).getTagList();

    // build-flutter_widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo ListView'),
      ),
      body: todoListAV.when(data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ProviderScope(
              overrides: [currentIndexItem.overrideWithValue(data[index])],
              child: const TodoItemView(),
            );
          },
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }, error: (error, _) {
        print(error.toString());
        return const Center(
          child: LinearProgressIndicator(),
        );
      }),
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
        watch(todoItemProvider).state = item;
        Navigator.of(context).pushNamed('/regist');
      },
      child: ListTile(title: Text(item.title ?? 'NO-TITLE')),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'model/todo_model.dart';
import 'todo_provider.dart';

final currentIndexItem =
    ScopedProvider<TodoModel>((watch) => throw UnimplementedError());

class TodoListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // get-provider
    final todoListAV = watch(todoListNotifierProvider);

    // build-widget
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
      }, error: (_, __) {
        return const Center(
          child: LinearProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/regist');
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
    return ListTile(title: Text(item.title));
  }
}

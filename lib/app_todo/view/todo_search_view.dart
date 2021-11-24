import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_searched_list_sn_provider.dart';
import 'package:flutter22_sample/app_todo/repository/algolia_av_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:algolia/algolia.dart';

final currentIndexItem =
ScopedProvider<TodoItem>((watch) => throw UnimplementedError());

class TodoSearchView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // get-provider
    final query = watch(queryStateProvider);
    final searched = watch(todoSearchedListSNProvider);

    // build-flutter_widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo SearchView'),
      ),
      body: ListView.builder(
        itemCount: searched.length,
        itemBuilder: (context, index) {
          return ProviderScope(
            overrides: [currentIndexItem.overrideWithValue(searched[index])],
            child: const TodoItemView(),
          );
        },
      )
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     watch(todoItemProvider).state = const TodoItem(tags: ['DEFAULT']);
      //     Navigator.of(context).pushNamed('/regist');
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

class TodoItemView extends ConsumerWidget {
  const TodoItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final item = watch(currentIndexItem);
    // var title = item.title .data['title'] as String;
    // var description = item.data['description'] as String;
    return GestureDetector(
      onTap: () {
        // watch(todoItemProvider).state = item;
        // Navigator.of(context).pushNamed('/regist');
      },
      child: ListTile(title: Text(item.title ?? ''), subtitle: Text(item.description ?? ''),),
    );
  }
}

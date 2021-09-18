import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../model/todo_model.dart';
import '../todo_list_notifier.dart';

final todoModelProvider = StateProvider<TodoModel>(
    (ref) => const TodoModel(id: null, description: ''));

class TodoRegisterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // get-provider
    final notifier = context.read(todoListNotifierProvider.notifier);
    final toDoModel = watch(todoModelProvider);

    // build-flutter_widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo 登録'),
      ),
      body: Container(
        padding: const EdgeInsets.all(64), // 余白
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // テキスト入力
            TextField(onChanged: (String title) {
              toDoModel.state = TodoModel(id: 'id', title: title);
            }),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity, // 横幅いっぱい
              child: ElevatedButton(
                onPressed: () {
                  notifier.add(toDoModel.state.title?? 'NO-TITLE');
                  Navigator.of(context).pop(); // 前の画面に戻る
                },
                child:
                    const Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity, // 横幅いっぱい
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  Navigator.of(context).pop(); // 前の画面に戻る
                },
                child: const Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

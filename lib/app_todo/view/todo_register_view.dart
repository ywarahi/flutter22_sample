import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../model/todo_model.dart';
import '../todo_list_notifier.dart';

final todoModelProvider = StateProvider<TodoModel>((ref) => const TodoModel());

class TodoRegisterView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // get-provider
    final notifier = context.read(todoListNotifierProvider.notifier);
    final toDoModel = watch(todoModelProvider);
    final _formKey = GlobalKey<FormState>();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    // build-flutter_widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo 登録'),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(64), // 余白
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // TextField(onChanged: (String title) {
                //   toDoModel.state = TodoModel(id: 'id', title: title);
                // }),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '件名 *',
                    hintText: '件名を入力してください',
                  ),
                  onSaved: (value) {
                    toDoModel.state = toDoModel.state.copyWith(title: value);
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '内容 *',
                    hintText: '内容を入力してください',
                  ),
                  onSaved: (value) {
                    toDoModel.state =
                        toDoModel.state.copyWith(description: value);
                  },
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity, // 横幅いっぱい
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        notifier.add(toDoModel.state);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('更新完了')),
                        );
                      }
                      Navigator.of(context).pop(); // 前の画面に戻る
                    },
                    child: const Text('リスト追加',
                        style: TextStyle(color: Colors.white)),
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
          )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

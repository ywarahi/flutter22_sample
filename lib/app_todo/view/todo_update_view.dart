import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_item_notifier.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_list_notifier.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_tag_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class TodoUpdateView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todoList = context.read(todoListNotifierProvider.notifier);
    final todoItem = watch(todoItemProvider);
    final tagListAV = watch(tagListNotifierProvider);
    final _formKey = GlobalKey<FormState>();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    //tagListAV.data.map(data: data, loading: loading, error: error)

    print(tagListAV.toString());

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
                TextFormField(
                  // id
                  readOnly: true,
                  style: const TextStyle(color: Colors.grey),
                  initialValue: todoItem.state.id ?? '(新規)',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                  ),
                ), // id
                const SizedBox(height: 8),
                TextFormField(
                  // title
                  initialValue: todoItem.state.title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '件名 *',
                    hintText: '件名を入力してください',
                  ),
                  onSaved: (value) {
                    todoItem.state = todoItem.state.copyWith(title: value);
                  },
                ), // title
                const SizedBox(height: 8),
                TextFormField(
                  // description
                  initialValue: todoItem.state.description,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '内容 *',
                    hintText: '内容を入力してください',
                  ),
                  onSaved: (value) {
                    todoItem.state =
                        todoItem.state.copyWith(description: value);
                  },
                ), // description
                const SizedBox(height: 8),
                DropdownButton<String>(
                  items: const [
                    DropdownMenuItem<String>(
                      child: Text('zzz'),
                    ),
                    // DropdownMenuItem<String>(
                    //   child: Text('yyy'),
                    // )
                  ],
                ),
                SizedBox(
                  width: double.infinity, // 横幅いっぱい
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (todoItem.state.id?.isNotEmpty ?? false) {
                          todoList.updateItem(todoItem.state);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('更新完了')),
                          );
                        } else {
                          todoList.createItem(todoItem.state);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('登録完了')),
                          );
                        }
                      }
                      Navigator.of(context).pop(); // 前の画面に戻る
                    },
                    child:
                        const Text('更新', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity, // 横幅いっぱい
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 前の画面に戻る
                    },
                    child: const Text('キャンセル'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

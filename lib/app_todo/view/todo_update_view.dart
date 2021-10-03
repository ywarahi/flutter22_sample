import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

//import '../model/todo_model.dart';
import '../todo_model_notifier.dart';

class TodoUpdateView extends ConsumerWidget {
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
                TextFormField(
                  // id
                  readOnly: true,
                  style: const TextStyle(color: Colors.grey),
                  initialValue: toDoModel.state.id ?? '(新規)',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                  ),
                ), // id
                const SizedBox(height: 8),
                TextFormField(
                  // title
                  initialValue: toDoModel.state.title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '件名 *',
                    hintText: '件名を入力してください',
                  ),
                  onSaved: (value) {
                    toDoModel.state = toDoModel.state.copyWith(title: value);
                  },
                ), // title
                const SizedBox(height: 8),
                TextFormField(
                  // description
                  initialValue: toDoModel.state.description,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '内容 *',
                    hintText: '内容を入力してください',
                  ),
                  onSaved: (value) {
                    toDoModel.state =
                        toDoModel.state.copyWith(description: value);
                  },
                ), // description
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity, // 横幅いっぱい
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (toDoModel.state.id?.isNotEmpty ?? false) {
                          notifier.updateItem(toDoModel.state);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('更新完了')),
                          );
                        } else {
                          notifier.createItem(toDoModel.state);
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

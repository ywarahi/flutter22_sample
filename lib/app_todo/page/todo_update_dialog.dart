import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_item_update_provider.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_list_sn_provider.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_tag_list_sn_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'abstract_modal_dialog.dart';

class TodoUpdateDialog extends AbstractModalDialog {
  @override
  Widget get childWidget {
    return Consumer(builder: (context, watch, child) {
      final todoList = context.read(todoListSNProvider.notifier);
      final tagList = context.read(todoTagListSNProvider);
      final todoItem = watch(todoItemUpdateProvider);
      final _formKey = GlobalKey<FormState>();

      final z = todoItem.state.tags;

      return Form(
        key: _formKey,
        child: Container(
          //decoration: const BoxDecoration(color: Colors.white),
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
                  todoItem.state = todoItem.state.copyWith(description: value);
                },
              ), // description
              SizedBox(
                width: double.infinity, // 横幅いっぱい
                // height: 8
                child: DropdownButton<String>(
                  //value: todoItem.state.tags?.first,
                  onChanged: (newValue) {
                    print('$newValue is selected');
                  },
                  items: tagList
                      .map((e) => DropdownMenuItem<String>(
                            value: e.name!,
                            child: Text(e.name!),
                          ))
                      .toList()),
              ),
              SizedBox(
                width: double.infinity, // 横幅いっぱい
                child: ElevatedButton(
                  //更新ボタン
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
                //キャンセルボタン
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
        ),
      );
    });
  }
}

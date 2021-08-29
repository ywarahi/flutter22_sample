import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'view/todo_listview.dart';
import 'view/todo_register_view.dart';

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => TodoListView(),
          '/regist': (BuildContext context) => TodoRegisterView(),
        }
    );
  }
}

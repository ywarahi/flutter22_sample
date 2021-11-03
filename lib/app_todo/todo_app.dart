import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_property_notifier.dart';
import 'package:flutter22_sample/app_todo/view/todo_list_view.dart';
import 'package:flutter22_sample/app_todo/view/todo_update_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

Future<void> sub() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(),
  ]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final propertyAV = watch(todoPropertyStateNotifierProvider);
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          '/list': (BuildContext context) => TodoListView(),
          '/regist': (BuildContext context) => TodoUpdateView(),
        },
        home: propertyAV.when(
          data: (data) => TodoListView(),
          error: (_, __) => const Scaffold(body: Text('error')),
          loading: () => const Scaffold(body: Text('splash')),
        ));
  }
}

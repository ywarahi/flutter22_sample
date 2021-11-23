import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_property_notifier.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_tag_list_notifier.dart';
import 'package:flutter22_sample/app_todo/view/todo_list_view.dart';
import 'package:flutter22_sample/app_todo/view/todo_update_view.dart';
import 'package:flutter22_sample/app_todo/view/todo_search_view.dart';
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
    final tagListAV = watch(tagListNotifierProvider);

    return MaterialApp(
        routes: <String, WidgetBuilder>{
          '/list': (BuildContext context) => TodoListView(),
          '/regist': (BuildContext context) => TodoUpdateView(),
          '/search': (BuildContext context) => TodoSearchView(),
        },
        home: (propertyAV is AsyncError || tagListAV is AsyncError)
            ? const Scaffold(body: Text('error'))
            : (propertyAV is AsyncLoading || tagListAV is AsyncLoading)
                ? const Scaffold(body: Text('splash'))
                : TodoListView()
        // propertyAV.when(
        //   data: (data) => TodoListView(),
        //   error: (_, __) => const Scaffold(body: Text('error')),
        //   loading: () => const Scaffold(body: Text('splash')),
        // )
        );
  }
}

// return AsyncValue.merge(
// data: (read) {
// return Text('${read(user).name} ${read(profile).name}');
// },
// loading: () => CircularProgressIndicator(),
// error: (err, stack) => Text('error'),
// );

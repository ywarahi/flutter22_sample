import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_property_sn_provider.dart';
import 'package:flutter22_sample/app_todo/notifier/todo_tag_list_sn_provider.dart';
import 'package:flutter22_sample/app_todo/todo_pages.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> sub() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(),
  ]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      home: Consumer(builder: (context, watch, child) {
        final propertyAV = watch(todoPropertySNProvider);
        final tagList = watch(todoTagListSNProvider);

        if (propertyAV is AsyncError) {
          return const Scaffold(body: Text('error'));
        } else if (propertyAV is AsyncLoading || tagList.isEmpty) {
          return const Scaffold(body: Text('loading...'));
        }
        return TodoPages();
      }),
    );
  }
}

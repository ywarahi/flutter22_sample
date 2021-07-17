import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 非同期で一回だけ実行される
final countReadProvider = FutureProvider<int>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 5));

  final sharedPreferences = await SharedPreferences.getInstance();
  final init = sharedPreferences.getInt('counter') ?? -1;
  return init;
});

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final initCounter = watch(countReadProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Future Provider (with Consumer Widget)'),
        ),
        body: initCounter.when( // 実行状態によって処理分岐
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
            data: (value) => Center(
                  child: Text('Count: $value'),
                )),
      ),
    );
  }
}

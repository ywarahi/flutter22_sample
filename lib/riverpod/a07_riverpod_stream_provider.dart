import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

// 非同期で複数回実行される
final diceReadProvider = StreamProvider<int>((ref) async* {
  await Future<void>.delayed(const Duration(seconds: 5));
  final random = Random();

  for (var i = 0; i < 10; ++i) {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield random.nextInt(6) + 1;
  }
});

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final dice = watch(diceReadProvider);

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Stream Provider (with Consumer Widget)'),
          ),
          body: dice.when( // 実行状態によって処理分岐
            data: (v) => Center(
              child: Text('Count: $v'),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          )),
    );
  }
}

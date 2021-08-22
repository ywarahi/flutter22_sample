import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

// 非同期で一回だけ実行される
final diceReadProvider = FutureProvider<int>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  final random = Random();
  return random.nextInt(6) + 1;
});

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final initCounter = watch(diceReadProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Future Provider (with Consumer Widget)'),
        ),
        body: initCounter.when(
            // 実行状態によって処理分岐
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
            data: (value) => RefreshIndicator(
                  onRefresh: () => context.refresh(diceReadProvider),
                  child: ListView(
                    children: [
                      ListTile(
                        title: const Text('DICE'),
                        subtitle: Text('Count: ${value}'),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}

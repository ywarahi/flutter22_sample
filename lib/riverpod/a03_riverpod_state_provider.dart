import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final countProvider = StateProvider((ref) => 0);

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // 外部データを参照。データ変更時にwidget再構築。
    final counter = watch(countProvider);

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('State Provider (with Consumer Widget)'),
            ),
            body: Center(
                    child: ElevatedButton(
                      onPressed: () => counter.state++, //直接的に状態変更
                      child: Text('Count: ${counter.state}'), //状態参照
                    ))
            ));
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('State Provider (with Consumer)'),
            ),
            body: Consumer(
              builder: (context, watch, child) {
                final counter = watch(countProvider);
                return Center(
                    child: ElevatedButton(
                  onPressed: () => counter.state++,
                  child: Text('Count: ${counter.state}'),
                ));
              },
            )));
  }
}

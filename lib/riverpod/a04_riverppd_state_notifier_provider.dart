import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final countProvider = StateNotifierProvider<CountStateNotifier, int>(
  (ref) => CountStateNotifier(0),
);

class CountStateNotifier extends StateNotifier<int> {
  CountStateNotifier(int state) : super(state);

  void add() {
    state = state + 1;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('State Notifier Provider (with Consumer)'),
            ),
            body: Consumer(
              builder: (context, watch, child) {
                // 外部データを参照。データ変更時にwidget再構築。
                final count = watch(countProvider);
                final counter = watch(countProvider.notifier);

                return Center(
                    child: ElevatedButton(
                  onPressed: () => counter.add(), //状態変更メソッドを呼び出し
                  child: Text('Count: $count'),
                ));
              },
            )));
  }
}

class MyApp2 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final count = watch(countProvider);
    final counter = watch(countProvider.notifier);

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider (with ConsumerWidget)'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () => counter.add(),
        child: Text('Count: $count'),
      )),
    ));
  }
}

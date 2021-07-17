import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final counterProvider = ChangeNotifierProvider((ref) => Counter());

class Counter extends ChangeNotifier {
  int count = 0;

  void add() {
    count = count + 1;
    notifyListeners();
  }
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Change Notifier P... (with Consumer)'),
            ),
            body: Consumer(
              builder: (context, watch, child) {
                final counter = watch(counterProvider);
                return Center(
                    child: ElevatedButton(
                  onPressed: () => counter.add(),
                  child: Text('Count: ${counter.count}'),
                ));
              },
            )));
  }
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // 外部データを参照。データ変更時にwidget再構築。
    final counter = watch(counterProvider);

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier P... (with ConsumerWidget)'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () => counter.add(), //状態変更メソッドを呼び出し
        child: Text('Count: ${counter.count}'),
      )),
    ));
  }
}

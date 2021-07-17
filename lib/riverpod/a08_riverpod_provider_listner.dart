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
        home: ProviderListener<int>(
          provider: countProvider,
          onChange: (context, count) { //変更されたとき呼び出しされる
            print('$count');
            if (count == 5) {
              print('OK');//showDialog(...);
            }
          },
          child: Scaffold(
              appBar: AppBar(
                title: const Text('ProviderListener'),
              ),
              body: Consumer(
                builder: (context, watch, child) {
                  // 外部データを参照。データ変更時にwidget再構築。
                  final count = watch(countProvider);
                  final counter = watch(countProvider.notifier);

                  return Center(
                      child: ElevatedButton(
                        onPressed: () => counter.add(),
                        child: Text('Count: ${count}'),
                      ));
                },
              )),
        )
    );
  }
}

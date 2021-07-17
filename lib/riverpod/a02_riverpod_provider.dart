import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final titleProvider = Provider((ref) => 'Riverpod Provider 2');

// ProviderをConsumerで受けるケース
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            //title: Text(title),
              title: Consumer( // 外部データを参照。データ変更時にwidget再構築。
                builder: (context, watch, child) {
                  final title = watch(titleProvider);
                  return Text(title);
                },)
          ),
          body: const Text('Any'),
        ));
  }
}

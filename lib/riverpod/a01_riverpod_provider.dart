import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final titleProvider = Provider((ref) => 'Riverpod Provider 1');

// ProviderをConsumerWidgetで受けるケース
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // 外部データを参照。データ変更時にwidget再構築。
    final title = watch(titleProvider);

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Text('Any'),
    ));
  }
}

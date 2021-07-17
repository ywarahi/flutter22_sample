import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final currentIndex = ScopedProvider<int>((watch) => throw UnimplementedError());

// ProviderをConsumerで受けるケース
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('ProviderListener'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ProviderScope(
          overrides: [currentIndex.overrideWithValue(index)],
          child: const ItemTile(),
        );
      }),
    ));
  }
}

class ItemTile extends ConsumerWidget {
  const ItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // アイテムのIndexを取得
    final index = watch(currentIndex);
    return ListTile(title: Text('$index番目のLIST'));
  }
}

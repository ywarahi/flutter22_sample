import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final dataListProvider = StateProvider((ref) => ['one', 'two', 'three', 'four']);
final currentData =
    ScopedProvider<String>((watch) => throw UnimplementedError());

// ProviderをConsumerで受けるケース
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final dataList = watch(dataListProvider).state;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('ProviderListener'),
      ),
      body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return ProviderScope(
              overrides: [currentData.overrideWithValue(dataList[index])],
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
    final current = context.read(currentData);
    final dataList = context.read(dataListProvider).state;

    return Dismissible(
      key: Key(current),
      onDismissed: (direction) {
        dataList.remove(current);
        if (direction == DismissDirection.endToStart) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('左から右')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('右から左')));
        }
      },
      background: Container(color: Colors.amberAccent),
      secondaryBackground: Container(color: Colors.greenAccent),
      child: ListTile(title: Text('$current番目のLIST')),
    );
  }
}

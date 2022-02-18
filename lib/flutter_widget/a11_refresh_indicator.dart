import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final dataListProvider =
    StateProvider<List<int>>((ref) => [100, 101, 102, 103]);
final currentData = ScopedProvider<int>((watch) => throw UnimplementedError());

// ProviderをConsumerで受けるケース
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final dataListPrv = watch(dataListProvider);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Provider Listener'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final list = [...dataListPrv.state]
            ..insert(0, dataListPrv.state.first - 1);
          dataListPrv.state = list;
        },
        child: ListView.builder(
            itemCount: dataListPrv.state.length,
            itemBuilder: (context, index) {
              return ProviderScope(
                overrides: [
                  currentData.overrideWithValue(dataListPrv.state[index])
                ],
                child: const ItemTile(),
              );
            }),
      ),
    ));
  }
}

class ItemTile extends ConsumerWidget {
  const ItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // アイテムのIndexを取得
    final current = watch(currentData);
    return ListTile(title: Text('$current番目のLIST'));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final dataList1Provider = StateProvider<List<String>>((ref) => ['1', '2']);
final selected1Provider = StateProvider<String>((ref) => '1');
final dataList2Provider =
    StateProvider<List<String>>((ref) => ['1', '2', 'three', 'four']);
final selected2Provider = StateProvider<String>((ref) => '1');

final currentData =
    ScopedProvider<String>((watch) => throw UnimplementedError());

// ProviderをConsumerで受けるケース
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final dataList1 = watch(dataList1Provider).state;
    final selected1 = watch(selected1Provider);
    final dataList2 = watch(dataList2Provider).state;
    final selected2 = watch(selected2Provider);

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('ProviderListener'),
      ),
      body: Column(
        children: [
          const Text(
            'What did you do?',
            style: TextStyle(fontSize: 24),
          ),
          DropdownButton<String>(
              value: selected1.state, // DropdownList中に値がないとダメ
              items: [
                DropdownMenuItem<String>(
                  value: dataList1[0],
                  child: Text(dataList1[0]),
                ),
                DropdownMenuItem<String>(
                  value: dataList1[1],
                  child: Text(dataList1[1]),
                )
              ],
              onChanged: (newValue) {
                selected1.state = newValue!; // watch or setStateしないと選択表示されない
                print('Dropdwon1: $newValue is selected');
              }),
          DropdownButton<String>(
            value: selected2.state,
            items: dataList2
                .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (newValue) {
              selected2.state = newValue ?? 'unselected';
              print('Dropdwon2: $newValue is selected');
            },
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            elevation: 16,
            style: const TextStyle(fontSize: 20, color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ));
  }
}

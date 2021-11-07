import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final dataListProvider = StateProvider((ref) => ['1', '2', 'three', 'four']);
final selectedProvider = StateProvider((ref) => '1');

final currentData =
    ScopedProvider<String>((watch) => throw UnimplementedError());

// ProviderをConsumerで受けるケース
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final dataList = watch(dataListProvider).state;
    final selected = watch(selectedProvider);
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
              items: const [
                DropdownMenuItem<String>(
                  value: '1',
                  child: Text('1'),
                ),
                DropdownMenuItem<String>(
                  value: '2',
                  child: Text('2'),
                )
              ],
              onChanged: (newValue) {
                print('$newValue is selected');
              }),
          DropdownButton<String>(
            value: selected.state,
            items: dataList
                .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (newValue) {
              selected.state = newValue ?? 'unselected';
              print('$newValue is selected');
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

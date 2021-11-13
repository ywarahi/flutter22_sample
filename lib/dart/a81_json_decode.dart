import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jsonMapProvider = StateNotifierProvider<JsonMapStateNotifier,
    AsyncValue<Map<String, dynamic>>>(
  (ref) => JsonMapStateNotifier(),
);

class JsonMapStateNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  JsonMapStateNotifier() : super(const AsyncValue.loading()) {
    Future<void>(() async {
      await Future<void>.delayed(const Duration(seconds: 3));
      final text = await rootBundle.loadString('assets/sample.json');
      final map = json.decode(text) as Map<String, dynamic>;
      print(map);
      state = AsyncValue.data(map);
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('RootBundle')),
            body: Consumer(builder: (context, watch, child) {
              final jsonMap = watch(jsonMapProvider);
              Widget result = const Text('loading...');
              jsonMap.maybeWhen(
                  data: (map) {
                    result = Column(
                      children: [
                        Text(map['name'].toString()),
                        Text(map['age'].toString()),
                        Text(map['hobby'].toString()),
                      ],
                    );
                  },
                  orElse: () {});
              return result;
            })));
  }
}

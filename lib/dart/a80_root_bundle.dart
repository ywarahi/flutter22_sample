import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

//https://flutter.dev/docs/development/ui/assets-and-images#from-packages
//
//①pubspec.yamlにバンドルするファイルのパスを記述
// flutter:
//   assets:
//     - assets/sample.json
//     - assets/splash.png
//
//

final jsonTextProvider =
    StateNotifierProvider<JsonTextStateNotifier, AsyncValue<String>>(
  (ref) => JsonTextStateNotifier(),
);

class JsonTextStateNotifier extends StateNotifier<AsyncValue<String>> {
  JsonTextStateNotifier() : super(const AsyncValue.loading()) {
    Future<void>(() async {
      await Future<void>.delayed(const Duration(seconds: 3));
      state =
          AsyncValue.data(await rootBundle.loadString('assets/sample.json'));
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
              final jsonText = watch(jsonTextProvider);
              return Text(jsonText.maybeWhen(
                data: (value) => value,
                orElse: () => 'loading...',
              ));
            })));
  }
}

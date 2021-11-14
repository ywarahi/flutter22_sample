import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ファイル ⇨ RootBundle ⇨ StateNotifierProvider ⇨ String
// 画像ファイル ⇨ AssetImage ⇨ 画像（ImageProvider）

//https://flutter.dev/docs/development/ui/assets-and-images#from-packages
//
//事前にpubspec.yamlにバンドルするファイルのパスを記述
// flutter:
//   assets:
//     - assets/sample.json
//     - assets/splash.png

final fileTextProvider =
    StateNotifierProvider<FileTextStateNotifier, AsyncValue<String>>(
  (ref) => FileTextStateNotifier(),
);

class FileTextStateNotifier extends StateNotifier<AsyncValue<String>> {
  FileTextStateNotifier() : super(const AsyncValue.loading()) {
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
              final fileText = watch(fileTextProvider);
              return Column(
                children: [
                  Text(fileText.maybeWhen(
                    data: (value) => value,
                    orElse: () => 'loading...',
                  )),
                  const Image(image: AssetImage('assets/splash.png'))
                ],
              );
            })));
  }
}

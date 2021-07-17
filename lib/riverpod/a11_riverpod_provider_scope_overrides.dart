import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

final countReadProvider = Provider<int>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final init = sharedPreferences.getInt('counter') ?? -1;
  return init;
});

void sub() async {
  // runApp関数が終わる前に何か処理を実行する場合、呼び出す
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          // ここでインスタンス化し、Providerの値を上書きします
          await SharedPreferences.getInstance(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // 外部データを参照。データ変更時にwidget再構築。
    final counter = watch(countReadProvider);

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('State Provider (with Consumer Widget)'),
            ),
            body: Center(
              child: Text('Count: ${counter}'),
            )));
  }
}

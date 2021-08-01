import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

final countControlProvider = ChangeNotifierProvider<CountControl>((ref) {
  return CountControl(ref.watch(sharedPreferencesProvider));
});

class CountControl extends ChangeNotifier {
  CountControl(this.sharedPreference) {
    if (sharedPreference.getInt('count') == null) {
      initialize();
    }
  }

  SharedPreferences sharedPreference;

  int initialize() {
    sharedPreference.setInt('count', 0);
    return sharedPreference.getInt('count')!!;
  }

  int get count {
    return sharedPreference.getInt('count') ?? initialize();
  }

  void add() {
    sharedPreference.setInt('count', count + 1);
    notifyListeners();
  }
}

Future<SharedPreferences> getSPInstance() async {
  for (int i in [1,2,3]) {
    await Future<void>.delayed(const Duration(seconds: 1));
    print('delay:$i');
  }
  return await SharedPreferences.getInstance();
}

Future<void> sub() async {
  // runApp関数が終わる前に何か処理を実行する場合、呼び出す
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(
          // ここでインスタンス化し、Providerの値を上書き
          await getSPInstance(),
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
    final countControl = watch(countControlProvider);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preference'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: countControl.add, //状態変更メソッドを呼び出し
        child: Text('Count: ${countControl.count}'),
      )),
    ));
  }
}

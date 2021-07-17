import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Stateful Widget'),),
      body:
        MyStatePage(),
    ));
  }
}

class MyStatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

// 状態はこのクラスで保持する
class MyState extends State<MyStatePage> {
  int _counter = 0;

  void _incrementCounter() {
    // データ変更時にwidget再構築。
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          onPressed: () => _incrementCounter,
          child: Text('Count: ${_counter}'),
        )
    );
  }
}

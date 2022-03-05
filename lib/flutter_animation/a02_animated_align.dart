import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool flag = false;

  Future<void> _click() async {
    setState(() {
      flag = !flag;
    });
  }

  Widget createField(Color background, Widget child, {double height=150}) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Container(
        color: background,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createField(
                Colors.black26,
                AnimatedAlign(
                    duration: const Duration(seconds: 3),
                    alignment: flag ? Alignment.centerLeft : Alignment.centerRight,
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Container(color: Colors.blue)))),
            createField(
                Colors.black12,
                AnimatedAlign(
                    duration: const Duration(seconds: 3),
                    alignment: flag ? Alignment.topCenter : Alignment.bottomCenter,
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Container(color: Colors.blue)))),
            createField(
                Colors.black26,
                AnimatedAlign(
                    duration: const Duration(seconds: 3),
                    alignment: flag ? Alignment.topLeft : Alignment.bottomRight,
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Container(color: Colors.blue)))),
            createField(
                Colors.black12,
                AnimatedAlign(
                    duration: const Duration(seconds: 3),
                    alignment: flag ? Alignment.topRight : Alignment.bottomLeft,
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Container(color: Colors.blue)))),
          ],
        ),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(onPressed: _click, child: const Icon(Icons.add)),
      ]),
    );
  }
}

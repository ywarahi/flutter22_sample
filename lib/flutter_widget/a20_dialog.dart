import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Dialog'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GestureDetector(
            onTapDown: (details) => print('(1) onTapDown'),
            onTapCancel: () => print('(e) onTapCancel'),
            onTapUp: (details) => print('(2) onTapUp'),
            onTap: () => print('(3) onTap'),
            child: Container(
              color: Colors.cyanAccent,
              width: 200,
              height: 100,
              child: const Text('onTap'),
            ),
          ), // onTap
          GestureDetector(
            onDoubleTap: () {
              print('onDoubleTap');
            },
            child: Container(
              color: Colors.cyanAccent,
              width: 200,
              height: 100,
              child: const Text('onDoubleTap'),
            ),
          ), // onDoubleTap
          GestureDetector(
            onLongPressStart: (details) => print('(1) onLongPressStart'),
            onLongPress: () => print('(2) onLongPress'),
            onLongPressMoveUpdate: (details) =>
                print('(3x) onLongPressMoveUpdate'),
            onLongPressEnd: (details) => print('(4) onLongPressEnd'),
            onLongPressUp: () => print('(5) onLongPressUp'),
            child: Container(
              color: Colors.cyanAccent,
              width: 200,
              height: 100,
              child: const Text('onLongPress'),
            ),
          ), // onLongPress
        ],
      ),
    ));
  }
}

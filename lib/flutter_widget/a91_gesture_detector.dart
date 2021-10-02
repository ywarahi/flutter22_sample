import 'package:flutter/material.dart';

// Tab数が多すぎると視認性に問題あり、3〜5つが適切
final tabPages = <Widget>[
  Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        onDoubleTap: () {print('onDoubleTap');},
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
        onLongPressMoveUpdate: (details) => print('(3x) onLongPressMoveUpdate'),
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
  Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      GestureDetector(
        onHorizontalDragDown: (details) => print('() onHorizontalDragDown'),
        onHorizontalDragCancel: () => print('(c) onHorizontalDragCancel'),
        onHorizontalDragStart: (details) => print('() onHorizontalDragStart'),
        onHorizontalDragUpdate: (details) => print('() onHorizontalDragUpdate'),
        onHorizontalDragEnd: (details) => print('() onHorizontalDragEnd'),
        child: Container(
          color: Colors.cyanAccent,
          width: 200,
          height: 100,
          child: const Text('onHorizontalDrag'),
        ),
      ), // onTap
      GestureDetector(
        onPanDown: (details) => print('() onPanDown'),
        onPanCancel: () => print('(c) onPanCancel'),
        onPanStart: (details) => print('() onPanStart'),
        onPanUpdate: (details) => print('() onPanUpdate'),
        onPanEnd: (details) => print('() onPanEnd'),
        child: Container(
          color: Colors.cyanAccent,
          width: 200,
          height: 100,
          child: const Text('onHorizontalDrag'),
        ),
      ), // onDoubleTap
    ],
  ),
];

final tabItems = <Tab>[
  const Tab(icon: Icon(Icons.cloud_outlined), text: 'Tap-type'),
  const Tab(icon: Icon(Icons.cloud_outlined), text: 'Drag-type'),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample',
      home: DefaultTabController(
        initialIndex: 0,
        length: tabPages.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Gesture Detector'),
            bottom: TabBar(
              tabs: tabItems,
            ),
          ),
          body: TabBarView(
            children: tabPages,
          ),
        ),
      ),
    );
  }
}

// Container, Column, Row, Stack, Center

import 'package:flutter/material.dart';

// Tab数が多すぎると視認性に問題あり、3〜5つが適切
final tabPages = <Widget>[
  Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
        color: Colors.cyanAccent,
        height: 100,
        child: const Text('width(-) x height(100)'),
      ),
      Container(
        color: Colors.cyanAccent,
        width: 200,
        child: const Text('width(200) x height(-)'),
      ),
      Container(
        color: Colors.cyanAccent,
        width: 200,
        height: 100,
        child: const Text('width(200) x height(100)'),
      ),
      Container(
        color: Colors.cyanAccent,
        width: double.infinity,
        height: 100,
        child: const Text('width(infinity) x height(100)'),
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
        color: Colors.blue,
        width: 200,
        height: 100,
        child: const Text('width(200) x height(100)'),
      ),
      Container(
        color: Colors.blue,
        width: 200,
        height: 100,
        child: Container(
          margin: const EdgeInsets.all(20),
          color: Colors.green,
          child: const Text('margin(20): 外側の余白'),
        ),
      ),
      Container(
        color: Colors.blue,
        width: 200,
        height: 100,
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.green,
          child: const Text('padding(20): 内側の余白'),
        ),
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2), // 枠線
          borderRadius: BorderRadius.circular(8), // 角丸
        ),
        padding: const EdgeInsets.all(8),
        child: const Text('BoxDecoration.border'),
      ),
      Container(
        width: 200,
        height: 100,
        decoration: const BoxDecoration(
          // 背景画像
          image: DecorationImage(
            image: NetworkImage('https://placehold.jp/200x100.png'),
          ),
        ),
        child: const Text('BoxDecoration.image'),
      ),
    ],
  ),
];

final tabItems = <Tab>[
  const Tab(icon: Icon(Icons.cloud_outlined), text: 'size'),
  const Tab(icon: Icon(Icons.cloud_outlined), text: 'margin,padding'),
  const Tab(icon: Icon(Icons.cloud_outlined), text: 'decoration'),
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
            title: const Text('TabBar Widget'),
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

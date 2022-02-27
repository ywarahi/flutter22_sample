// Container, Column, Row, Stack, Center

import 'package:flutter/material.dart';

final tabItems = <Tab>[
  const Tab(icon: Icon(Icons.cloud_outlined), text: 'non-positioned'),
  //non-positioned
  const Tab(icon: Icon(Icons.cloud_outlined), text: 'positioned'),
  //positioned
  const Tab(icon: Icon(Icons.cloud_outlined), text: 'ListView'),
];

// Tab数が多すぎると視認性に問題あり、3〜5つが適切
final tabPages = <Widget>[
  Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Stack(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Container(
              color: Colors.orange,
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Container(
              color: Colors.cyan,
            ),
          ),
        ],
      ),
      Stack(
        children: [
          SizedBox(
            //小さな方を先に指定すると見えなくなる
            width: 100,
            height: 100,
            child: Container(
              color: Colors.cyan,
            ),
          ),
          SizedBox(
            width: 200,
            height: 200,
            child: Container(
              color: Colors.orange,
            ),
          ),
        ],
      ),
    ],
  ),
  Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Stack(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Container(
              color: Colors.orange,
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Container(
              color: Colors.cyan,
            ),
          ),
        ],
      ),
      Stack(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Container(
              color: Colors.orange,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: SizedBox(
              width: 100,
              height: 100,
              child: Container(
                color: Colors.cyan,
              ),
            ),
          ),
        ],
      ),
    ],
  ),
  Stack(
    children: [
      ListView.builder(
          itemCount: 1000,
          itemBuilder: (context, index) {
            return Text('$index');
          }),
      Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 100,
            color: Colors.cyan,
            child: const Text('test ddddddddddddkkkkkkkkkkk'),
          )),
    ],
  ),
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

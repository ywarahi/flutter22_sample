import 'package:flutter/material.dart';

final tabPages = <Widget>[
  const CustomPage(panelColor: Colors.cyan, title: 'Home'),
  const CustomPage(panelColor: Colors.green, title: 'Settings'),
  const CustomPage(panelColor: Colors.pink, title: 'Search')
];

final tabItems = <Tab>[
  const Tab(icon: Icon(Icons.cloud_outlined), text: 'cloud'),
  const Tab(icon: Icon(Icons.beach_access_sharp), text: 'beach'),
  const Tab(icon: Icon(Icons.brightness_5_sharp), text: 'sun'),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample',
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
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

class CustomPage extends StatelessWidget {
  const CustomPage({required this.panelColor, required this.title});

  final Color panelColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.title;
    return Container(
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              color: panelColor,
              borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleTextStyle!.fontSize,
                color: titleTextStyle.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

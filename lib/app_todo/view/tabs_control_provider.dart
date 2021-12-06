import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tabs_control.dart';

final tabsControlProvider = ChangeNotifierProvider(
    (ref) => TabsControl(_bottomBarItems, _topTabBarList, _tabBarViewChildrenList));

final _bottomBarItems = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: 'Search',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.info),
    label: 'About',
  ),
];

final _topTabBarList = <TabBar?>[
  null,
  const TabBar(tabs: <Widget>[
    Tab(icon: Icon(Icons.cloud_outlined), text: 'Search1'),
    Tab(icon: Icon(Icons.beach_access_sharp), text: 'Search2'),
    Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Search3'),
  ]),
  const TabBar(tabs: <Widget>[
    Tab(icon: Icon(Icons.cloud_outlined), text: 'About1'),
    Tab(icon: Icon(Icons.beach_access_sharp), text: 'About2'),
    Tab(icon: Icon(Icons.brightness_5_sharp), text: 'About3'),
  ])
];

final _tabBarViewChildrenList = <List<Widget>>[
  const <Widget>[
    _CustomPage(panelColor: Colors.cyan, title: 'Home1'),
    // _CustomPage(panelColor: Colors.pink, title: 'Home2'),
    // _CustomPage(panelColor: Colors.amberAccent, title: 'Home3'),
  ],
  const <Widget>[
    _CustomPage(panelColor: Colors.cyan, title: 'Search1'),
    _CustomPage(panelColor: Colors.pink, title: 'Search2'),
    _CustomPage(panelColor: Colors.amberAccent, title: 'Search3'),
  ],
  const <Widget>[
    _CustomPage(panelColor: Colors.cyan, title: 'About1'),
    _CustomPage(panelColor: Colors.pink, title: 'About2'),
    _CustomPage(panelColor: Colors.amberAccent, title: 'About3'),
  ]
];

class _CustomPage extends StatelessWidget {
  const _CustomPage({required this.panelColor, required this.title});

  final Color panelColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.headline6;
    return Container(
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              color: panelColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
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

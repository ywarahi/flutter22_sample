import 'package:flutter/material.dart';
import 'package:flutter22_sample/pkg_tabbed_view2/pkg_tabbed_view2.dart';

final bottomTabs = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.category),
    label: 'Category',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: 'Search',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: 'About',
  ),
];

final topTabsList = <List<Text>>[
  const <Text>[
    Text('Home'),
  ],
  const <Text>[
    Text('Category1'),
    Text('Category2'),
    Text('Category3'),
  ],
  const <Text>[
    Text('Search1'),
    Text('Search2'),
    Text('Search3'),
  ],
  const <Text>[
    Text('About1'),
    Text('About2'),
    Text('About3'),
    Text('About4'),
  ]
];

final pagesList = <List<Widget>>[
  <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'Home', key: UniqueKey()),
  ],
  <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'Category1', key: UniqueKey()),
    CustomPage(panelColor: Colors.pink, title: 'Category2', key: UniqueKey()),
    CustomPage(panelColor: Colors.amber, title: 'Category3', key: UniqueKey()),
  ],
  <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'Search1', key: UniqueKey()),
    CustomPage(panelColor: Colors.pink, title: 'Search2', key: UniqueKey()),
    CustomPage(panelColor: Colors.amber, title: 'Search3', key: UniqueKey()),
  ],
  <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'About1', key: UniqueKey()),
    CustomPage(panelColor: Colors.pink, title: 'About2', key: UniqueKey()),
    CustomPage(panelColor: Colors.amber, title: 'About3', key: UniqueKey()),
    CustomPage(panelColor: Colors.green, title: 'About4', key: UniqueKey()),
  ],
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfiniteScrollTabView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabbedView2(bottomTabs, topTabsList, pagesList),
      //      this._bottomTabs, this._topTabList, this._pagesList,
    );
  }
}

class CustomPage extends StatelessWidget {
  const CustomPage(
      {required this.panelColor, required this.title, required Key key})
      : super(key: key);

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

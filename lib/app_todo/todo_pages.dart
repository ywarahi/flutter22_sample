import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/page/todo_list_page.dart';
import 'package:flutter22_sample/app_todo/page/tabbed_page.dart';

class TodoPages extends TabbedPage {
  TodoPages() : super(bottomTabs, topTabsList, pagesList);
}

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

final topTabsList = <List<Tab>>[
  const <Tab>[
    Tab(icon: Icon(Icons.cloud_outlined), text: 'Home'),
    // Tab(icon: Icon(Icons.beach_access_sharp), text: 'Home2'),
    // Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Home3'),
  ],
  const <Tab>[
    Tab(icon: Icon(Icons.cloud_outlined), text: 'Category1'),
    Tab(icon: Icon(Icons.beach_access_sharp), text: 'Category2'),
    Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Category3'),
  ],
  const <Tab>[
    Tab(icon: Icon(Icons.cloud_outlined), text: 'Search1'),
    Tab(icon: Icon(Icons.beach_access_sharp), text: 'Search2'),
    Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Search3'),
  ],
  const <Tab>[
    Tab(icon: Icon(Icons.cloud_outlined), text: 'About1'),
    Tab(icon: Icon(Icons.beach_access_sharp), text: 'About2'),
    Tab(icon: Icon(Icons.brightness_5_sharp), text: 'About3'),
    Tab(icon: Icon(Icons.access_time_filled_sharp), text: 'About4'),
  ]
];

final pagesList = <List<Widget>>[
  <Widget>[
    TodoListPage(),
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

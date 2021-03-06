import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomBarItems = <BottomNavigationBarItem>[
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

final tabBarList = <TabBar>[
  const TabBar(tabs: <Widget>[
    Tab(icon: Icon(Icons.cloud_outlined), text: 'Home1'),
    Tab(icon: Icon(Icons.beach_access_sharp), text: 'Home2'),
    Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Home3'),
  ]),
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

final tabBarViewList = <TabBarView>[
  const TabBarView(children: <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'Home1'),
    CustomPage(panelColor: Colors.pink, title: 'Home2'),
    CustomPage(panelColor: Colors.amberAccent, title: 'Home3'),
  ]),
  const TabBarView(children: <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'Search1'),
    CustomPage(panelColor: Colors.pink, title: 'Search2'),
    CustomPage(panelColor: Colors.amberAccent, title: 'Search3'),
  ]),
  const TabBarView(children: <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'About1'),
    CustomPage(panelColor: Colors.pink, title: 'About2'),
    CustomPage(panelColor: Colors.amberAccent, title: 'About3'),
  ])
];

final tabsControlProvider = ChangeNotifierProvider(
    (ref) => TabsControl(bottomBarItems, tabBarList, tabBarViewList));

class TabsControl extends ChangeNotifier {
  TabsControl(this.bottomBarItems, this.tabBarList, this.tabBarViewList);

  int currentBottomTabIndex = 0;
  List<BottomNavigationBarItem> bottomBarItems;
  List<TabBar> tabBarList; //TabBar(tabs: tabItems,)
  List<TabBarView> tabBarViewList; //TabBarView(children: tabPages,)

  TabBar getCurrentTabBar() {
    return tabBarList[currentBottomTabIndex];
  }

  TabBarView getCurrentTabBarView() {
    return tabBarViewList[currentBottomTabIndex];
  }

  void onTap(int index) {
    currentBottomTabIndex = index;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  static const String _title = 'TabBar x BottomBar';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Consumer(
        builder: (context, watch, child) {
          final pageProvider = watch(tabsControlProvider);
          return DefaultTabController(
              initialIndex: 0,
              length: pageProvider.bottomBarItems.length,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('TabBar Widget'),
                  bottom: pageProvider.getCurrentTabBar(),
                ),
                body: pageProvider.getCurrentTabBarView(),
                bottomNavigationBar: BottomNavigationBar(
                  items: pageProvider.bottomBarItems,
                  currentIndex: pageProvider.currentBottomTabIndex,
                  onTap: pageProvider.onTap,
                ),
              ));
        },
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

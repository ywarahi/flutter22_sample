import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';

final bottomTabPages = <Widget>[
  MyTabsView(), //const CustomPage(panelColor: Colors.cyan, title: 'Home1'),
  const CustomPage(panelColor: Colors.green, title: 'Settings1'),
  const CustomPage(panelColor: Colors.pink, title: 'Search1')
];

final bottomTabItems = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home1',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Setting',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: 'Search',
  ),
];

final bottomTabsControlProvider = ChangeNotifierProvider(
        (ref) => BottomTabsControl(bottomTabItems, bottomTabPages));

class BottomTabsControl extends ChangeNotifier {
  BottomTabsControl(this.tabItems, this.tabPages);

  int currentIndex = 0;
  List<BottomNavigationBarItem> tabItems;
  List<Widget> tabPages;

  Widget getCurrentPage() {
    return IndexedStack(
      index: currentIndex,
      children: tabPages,
    );
  }

  void onTap(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void addPage(Icon icon, String label, Widget page) {
    tabItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.search), label: 'Search'));
    tabPages.add(page);
    notifyListeners();
  }
}

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Consumer(
        builder: (context, watch, child) {
          final pageProvider = watch(bottomTabsControlProvider);

          return Scaffold(
            appBar: AppBar(title: const Text('zzz')),
            body: pageProvider.getCurrentPage(),
            bottomNavigationBar: BottomNavigationBar(
              items: pageProvider.tabItems,
              currentIndex: pageProvider.currentIndex,
              onTap: pageProvider.onTap,
            ),
          );
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
    final titleTextStyle = Theme
        .of(context)
        .textTheme
        .headline6;
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

final topTabPages = <Widget>[
  const CustomPage(panelColor: Colors.cyan, title: 'Home'),
  const CustomPage(panelColor: Colors.green, title: 'Settings'),
  const CustomPage(panelColor: Colors.pink, title: 'Search')
];

final topTabItems = <Text>[
  const Text('Home'),
  const Text('Setting'),
  const Text('Search'),
];

final topTabsControlProvider =
ChangeNotifierProvider((ref) => TopTabsControl(topTabItems, topTabPages));

class TopTabsControl extends ChangeNotifier {
  TopTabsControl(this.tabItems, this.tabPages);

  int currentIndex = 0;
  List<Text> tabItems;
  List<Widget> tabPages;

  Widget getCurrentPage() {
    return IndexedStack(
      index: currentIndex,
      children: tabPages,
    );
  }

  void onTap(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

class MyTabsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, watch, child) {
          final pageProvider = watch(topTabsControlProvider);
          return InfiniteScrollTabView(
            contentLength: pageProvider.tabItems.length,
            onTabTap: pageProvider.onTap,
            tabBuilder: (index, isSelected) {
              return pageProvider.tabItems[index];
            },
            separator: const BorderSide(color: Colors.black12, width: 2),
            onPageChanged: (index) => debugPrint('page changed to $index.'),
            indicatorColor: Colors.pink,
            pageBuilder: (context, index, _) {
              return pageProvider.tabPages[index];
            },
          );
        });
  }
}
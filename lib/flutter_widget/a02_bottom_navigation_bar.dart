import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// BottomNavigationBarを持つ共通Scaffoldにて、複数のWidgetの遷移制御する

final bottomTabPages = <Widget>[
  const CustomPage(panelColor: Colors.cyan, title: 'Home'),
  const CustomPage(panelColor: Colors.pink, title: 'Search'),
  // const CustomPage(panelColor: Colors.green, title: 'Settings'),
  const CustomPage(panelColor: Colors.amberAccent, title: 'About'),
];

final bottomTabItems = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: 'Search',
  ),
  // const BottomNavigationBarItem(
  //   icon: Icon(Icons.settings),
  //   label: 'Setting',
  // ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.info),
    label: 'About',
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
    return tabPages[currentIndex];
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

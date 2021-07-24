import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabPages = <Widget>[
  const CustomPage(panelColor: Colors.cyan, title: 'Home'),
  const CustomPage(panelColor: Colors.green, title: 'Settings'),
  const CustomPage(panelColor: Colors.pink, title: 'Search')
];

final tabItems = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
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

final pageControlProvider =
ChangeNotifierProvider((ref) => PageControl(tabItems, tabPages));

class PageControl extends ChangeNotifier {
  PageControl(this.tabItems, this.tabPages);

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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Consumer(builder: (context, watch, child) {
        final pageProvider = watch(pageControlProvider);

        return Scaffold(
          body: pageProvider.getCurrentPage(),
          bottomNavigationBar: BottomNavigationBar(
            items: pageProvider.tabItems,
            currentIndex: pageProvider.currentIndex,
            onTap: pageProvider.onTap,
          ),
        );
      },),
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
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
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

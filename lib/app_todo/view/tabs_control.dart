import 'package:flutter/material.dart';

class TabsControl extends ChangeNotifier {
  TabsControl(this.bottomBarItems, this.topTabBarList, this.tabBarViewList);

  int currentBottomTabIndex = 0;
  List<TabBar> topTabBarList;
  List<TabBarView> tabBarViewList;
  List<BottomNavigationBarItem> bottomBarItems;

  TabBar getCurrentTopTabBar() {
    return topTabBarList[currentBottomTabIndex];
  }

  TabBarView getCurrentTabBarView() {
    return tabBarViewList[currentBottomTabIndex];
  }

  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
      items: bottomBarItems,
      currentIndex: currentBottomTabIndex,
      onTap: onTap,
    );
  }

  void onTap(int index) {
    currentBottomTabIndex = index;
    notifyListeners();
  }
}

Widget createDefaultScaffold(TabsControl tabsControl) {
  return DefaultTabController(
      initialIndex: 0,
      length: tabsControl.bottomBarItems.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Widget'),
          bottom: tabsControl.getCurrentTopTabBar(),
        ),
        body: tabsControl.getCurrentTabBarView(),
        bottomNavigationBar: tabsControl.getBottomNavigationBar(),
      ));
}

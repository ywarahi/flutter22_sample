import 'package:flutter/material.dart';

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

Widget createDefaultScaffold(TabsControl tabsControl) {
  return DefaultTabController(
      initialIndex: 0,
      length: tabsControl.bottomBarItems.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Widget'),
          bottom: tabsControl.getCurrentTabBar(),
        ),
        body: tabsControl.getCurrentTabBarView(),
        bottomNavigationBar: BottomNavigationBar(
          items: tabsControl.bottomBarItems,
          currentIndex: tabsControl.currentBottomTabIndex,
          onTap: tabsControl.onTap,
        ),
      ));
}

import 'package:flutter/material.dart';

class TabsControl extends ChangeNotifier {
  TabsControl(this.bottomBarItems, this.topTabBarList, this.tabBarViewChildrenList);

  int currentBottomTabIndex = 0;
  List<TabBar?> topTabBarList;
  //List<TabBarView> tabBarViewList;
  List<List<Widget>> tabBarViewChildrenList;
  List<BottomNavigationBarItem> bottomBarItems;

  TabBar? getCurrentTopTabBar() {
    var tabBar = topTabBarList[currentBottomTabIndex];
    return tabBar; // nullの場合、タブを作成しない
  }

  Widget getCurrentTabBarView() {
    if (topTabBarList[currentBottomTabIndex] == null) {
      return tabBarViewChildrenList[currentBottomTabIndex][0];
    }
    return TabBarView(children: tabBarViewChildrenList[currentBottomTabIndex]);
  }

  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
      items: bottomBarItems,
      currentIndex: currentBottomTabIndex,
      onTap: onTapBottomBar,
    );
  }

  void onTapBottomBar(int index) {
    currentBottomTabIndex = index;
    notifyListeners();
  }

  void onTapTopBar(int index) {
    //Todo
  }

  Widget createDefaultScaffold() {
    return DefaultTabController(
        initialIndex: 0,
        length: bottomBarItems.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TabBar Widget'),
            bottom: getCurrentTopTabBar(),
          ),
          body: getCurrentTabBarView(),
          bottomNavigationBar: getBottomNavigationBar(),
        ));
  }
}

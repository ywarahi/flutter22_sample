import 'package:flutter/material.dart';

class TopAndBottomTabbedPage extends StatefulWidget {
  const TopAndBottomTabbedPage(
      this._bottomTabs, this._topTabList, this._pagesList,
      {Key? key})
      : super(key: key);

  final List<List<Tab>> _topTabList;
  final List<BottomNavigationBarItem> _bottomTabs;
  final List<List<Widget>> _pagesList;

  @override
  State<TopAndBottomTabbedPage> createState() => _TopAndBottomTabbedPageState();
}

class _TopAndBottomTabbedPageState extends State<TopAndBottomTabbedPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _bottomTabIndex = 0;
  final List<int> _topTabIndexList = [];

  @override
  void initState() {
    super.initState();
    //_tabController = TabController(vsync: this, length: myTabs.length);
    for (var i = 0; i < widget._bottomTabs.length; i++) {
      _topTabIndexList.add(0);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  TabBar? getTopTabBar() {
    if (widget._pagesList[_bottomTabIndex].length == 1) {
      return null;
    } else {
      return TabBar(
        controller: _tabController,
        tabs: widget._topTabList[_bottomTabIndex],
      );
    }
  }

  Widget getCurrentPage() {
    if (widget._pagesList[_bottomTabIndex].length == 1) {
      return widget._pagesList[_bottomTabIndex][0];
    } else {
      // int topTabIndex = (_tabController?.index)??
      //     _topTabIndexList[_bottomTabIndex]?? 0;
      return TabBarView(
        controller: _tabController,
        children: widget._pagesList[_bottomTabIndex],
      );
    }
  }

  BottomNavigationBar getBottomTabBar() {
    return BottomNavigationBar(
      items: widget._bottomTabs,
      currentIndex: _bottomTabIndex,
      onTap: onTapBottomBar,
      type: BottomNavigationBarType.fixed,
    );
  }

  void onTapBottomBar(int index) {
    _topTabIndexList[_bottomTabIndex] = _tabController!.index;
    _bottomTabIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('build is called.');

    _tabController?.dispose();
    _tabController = TabController(
        vsync: this,
        length: widget._topTabList[_bottomTabIndex].length,
        initialIndex: _topTabIndexList[_bottomTabIndex]);

    return Scaffold(
        appBar: AppBar(
          bottom: getTopTabBar(),
        ),
        body: getCurrentPage(),
        bottomNavigationBar: getBottomTabBar());
  }
}

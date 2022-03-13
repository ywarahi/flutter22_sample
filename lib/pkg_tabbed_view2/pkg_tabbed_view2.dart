import 'package:flutter/material.dart';

class TabbedView2 extends StatefulWidget {
  const TabbedView2(
      this._bottomTabs, this._topTabList, this._pagesList,
      {Key? key})
      : super(key: key);

  final List<List<Tab>> _topTabList;
  final List<BottomNavigationBarItem> _bottomTabs;
  final List<List<Widget>> _pagesList;

  @override
  State<TabbedView2> createState() => _TabbedView2State();
}

class _TabbedView2State extends State<TabbedView2>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late int _bottomTabIndex;
  final List<int> _topTabIndexList = [];

  @override
  void initState() {
    _bottomTabIndex = 0;
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
        key: UniqueKey(),
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
        key: UniqueKey(),
        children: widget._pagesList[_bottomTabIndex],
      );
    }
  }

  BottomNavigationBar getBottomTabBar() {
    return BottomNavigationBar(
      items: widget._bottomTabs,
      currentIndex: _bottomTabIndex,
      onTap: (index) {
        _topTabIndexList[_bottomTabIndex] = _tabController!.index;
        _bottomTabIndex = index;
        setState(() {});
      },
      type: BottomNavigationBarType.fixed,
      key: UniqueKey(),
    );
  }

  @override
  Widget build(BuildContext context) {
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

//OLD//
// class TabbedWidget extends StatefulWidget {
//   const TabbedWidget(
//       this._bottomTabs, this._topTabList, this._pagesList,
//       {Key? key})
//       : super(key: key);
//
//   final List<List<Tab>> _topTabList;
//   final List<BottomNavigationBarItem> _bottomTabs;
//   final List<List<Widget>> _pagesList;
//
//   @override
//   State<TabbedWidget> createState() => _TabbedWidgetState();
// }
//
// class _TabbedWidgetState extends State<TabbedWidget>
//     with TickerProviderStateMixin {
//   TabController? _tabController;
//   late int _bottomTabIndex;
//   final List<int> _topTabIndexList = [];
//
//   @override
//   void initState() {
//     _bottomTabIndex = 0;
//     super.initState();
//     //_tabController = TabController(vsync: this, length: myTabs.length);
//     for (var i = 0; i < widget._bottomTabs.length; i++) {
//       _topTabIndexList.add(0);
//     }
//   }
//
//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }
//
//   TabBar? getTopTabBar() {
//     if (widget._pagesList[_bottomTabIndex].length == 1) {
//       return null;
//     } else {
//       return TabBar(
//         controller: _tabController,
//         tabs: widget._topTabList[_bottomTabIndex],
//         key: UniqueKey(),
//       );
//     }
//   }
//
//   Widget getCurrentPage() {
//     if (widget._pagesList[_bottomTabIndex].length == 1) {
//       return widget._pagesList[_bottomTabIndex][0];
//     } else {
//       // int topTabIndex = (_tabController?.index)??
//       //     _topTabIndexList[_bottomTabIndex]?? 0;
//       return TabBarView(
//         controller: _tabController,
//         key: UniqueKey(),
//         children: widget._pagesList[_bottomTabIndex],
//       );
//     }
//   }
//
//   BottomNavigationBar getBottomTabBar() {
//     return BottomNavigationBar(
//       items: widget._bottomTabs,
//       currentIndex: _bottomTabIndex,
//       onTap: onTapBottomBar,
//       type: BottomNavigationBarType.fixed,
//       key: UniqueKey(),
//     );
//   }
//
//   void onTapBottomBar(int index) {
//     _topTabIndexList[_bottomTabIndex] = _tabController!.index;
//     _bottomTabIndex = index;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _tabController?.dispose();
//     _tabController = TabController(
//         vsync: this,
//         length: widget._topTabList[_bottomTabIndex].length,
//         initialIndex: _topTabIndexList[_bottomTabIndex]);
//
//     return Scaffold(
//         appBar: AppBar(
//           bottom: getTopTabBar(),
//         ),
//         body: getCurrentPage(),
//         bottomNavigationBar: getBottomTabBar());
//   }
// }

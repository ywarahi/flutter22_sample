import 'package:flutter/material.dart';

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
    Tab(icon: Icon(Icons.cloud_outlined), text: 'Home1'),
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
    CustomPage(panelColor: Colors.cyan, title: 'Home1', key: UniqueKey()),
    // CustomPage(panelColor: Colors.pink, title: 'Home2'),
    // CustomPage(panelColor: Colors.amberAccent, title: 'Home3'),
  ],
  <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'Category1', key: UniqueKey()),
    CustomPage(panelColor: Colors.pink, title: 'Category2', key: UniqueKey()),
    CustomPage(panelColor: Colors.green, title: 'Category3', key: UniqueKey()),
  ],
  <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'Search1', key: UniqueKey()),
    CustomPage(panelColor: Colors.pink, title: 'Search2', key: UniqueKey()),
    CustomPage(panelColor: Colors.green, title: 'Search3', key: UniqueKey()),
  ],
  <Widget>[
    CustomPage(panelColor: Colors.cyan, title: 'About1', key: UniqueKey()),
    CustomPage(panelColor: Colors.pink, title: 'About2', key: UniqueKey()),
    CustomPage(panelColor: Colors.green, title: 'About3', key: UniqueKey()),
    CustomPage(panelColor: Colors.amber, title: 'About4', key: UniqueKey()),
  ],
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TopTabBar x BottomTabBar',
        home:
            MyTabbedPage(bottomTabs, topTabsList, pagesList, key: UniqueKey()));
  }
}

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage(this._bottomTabs, this._topTabList, this._pagesList,
      {Key? key})
      : super(key: key);

  final List<List<Tab>> _topTabList;
  final List<BottomNavigationBarItem> _bottomTabs;
  final List<List<Widget>> _pagesList;

  @override
  State<MyTabbedPage> createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _bottomTabIndex = 0;
  final List<int> _topTabIndexList = [];

  @override
  void initState() {
    super.initState();
    //_tabController = TabController(vsync: this, length: myTabs.length);
    for (var i = 0; i < widget._bottomTabs.length; i++) {
      _topTabIndexList.add(i);
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
          key: UniqueKey());
    }
  }

  Widget getCurrentPage() {
    print('getCurrentPage: ${_bottomTabIndex} / ${_tabController!.index}');

    if (widget._pagesList[_bottomTabIndex].length == 1) {
      return widget._pagesList[_bottomTabIndex][0];
    } else {
      // int topTabIndex = (_tabController?.index)??
      //     _topTabIndexList[_bottomTabIndex]?? 0;
      return TabBarView(
          controller: _tabController,
          children: widget._pagesList[_bottomTabIndex],
          key: UniqueKey());
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
    print('build: ${_bottomTabIndex} / ${_topTabIndexList[_bottomTabIndex]}');

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

// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
//
// class MyTabbedPage extends StatefulWidget {
//   const MyTabbedPage({ Key? key }) : super(key: key);
//   @override
//   State<MyTabbedPage> createState() => _MyTabbedPageState();
// }
//
// class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
//   static const List<Tab> myTabs = <Tab>[
//     Tab(text: 'LEFT'),
//     Tab(text: 'RIGHT'),
//   ];
//
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: myTabs.length);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: myTabs,
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: myTabs.map((Tab tab) {
//           final String label = tab.text!.toLowerCase();
//           return Center(
//             child: Text(
//               'This is the $label tab',
//               style: const TextStyle(fontSize: 36),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

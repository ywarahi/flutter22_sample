import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  static const String _title = 'TopTabBar x BottomTabBar';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: _title, home: MyTabbedPage());
  }
}

class MyTabbedPage extends StatefulWidget {
  MyTabbedPage({Key? key}) : super(key: key);

  final _topTabList = <List<Tab>>[
    const <Tab>[
      Tab(icon: Icon(Icons.cloud_outlined), text: 'Home1'),
      Tab(icon: Icon(Icons.beach_access_sharp), text: 'Home2'),
      Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Home3'),
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

  final List<BottomNavigationBarItem> _bottomTabs = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
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
      _topTabIndexList.add(0);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void onBottomBarTap(int index) {
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
          bottom: TabBar(
            controller: _tabController,
            tabs: widget._topTabList[_bottomTabIndex],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: widget._topTabList[_bottomTabIndex].map((Tab tab) {
            final label = tab.text!.toLowerCase();
            return Center(
              child: Text(
                'This is the $_bottomTabIndex / $label tab',
                style: const TextStyle(fontSize: 36),
              ),
            );
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: widget._bottomTabs,
          currentIndex: _bottomTabIndex,
          onTap: onBottomBarTap,
        ));
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

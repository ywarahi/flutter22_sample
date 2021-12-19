import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  static const String _title = 'TabBar x BottomBar';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: _title, home: MyTabbedPage());
  }
}

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);

  @override
  State<MyTabbedPage> createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  final int _bottomTabIndex = 0;
  final int _bottomTabLength = 1;
  List<TabController> _tabController = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _bottomTabLength; i++) {
      _tabController.add(TabController(vsync: this, length: myTabs.length));
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < _bottomTabLength; i++) {
      _tabController[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController[_bottomTabIndex],
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController[_bottomTabIndex],
        children: myTabs.map((Tab tab) {
          final label = tab.text!.toLowerCase();
          return Center(
            child: Text(
              'This is the $_bottomTabIndex / $label tab',
              style: const TextStyle(fontSize: 36),
            ),
          );
        }).toList(),
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

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listview x Overscroll',
      home: Scaffold(
        appBar: AppBar(title: const Text('Test')),
        body: MyListViewPage(),
      ),
    );
  }
}

class MyListViewPage extends StatefulWidget {
  @override
  State createState() {
    return _MyListViewPageState();
  }
}

class _MyListViewPageState extends State {
  final ScrollController _controller = ScrollController();
  final _items = <String>[];
  var _loading = false;

  @override
  void initState() {
    super.initState();
    getData();
    //Add listening to the controller
    _controller.addListener(() {
      // //Determine if it slides to the bottom of the page
      // if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      //   //If it is not the last page of data, generate new data to add to the list
      //   if (_mPage < 4) {
      //     //_retrieveData();
      //   }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>( //OverscrollNotification
        child: ListView.separated(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(title: Text('${_items[index]}'));
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.blue,
              );
            },
            itemCount: _items.length),
        onNotification: (notification) {
          final metrics = notification.metrics;

          //print(notification.toString());
          print('${metrics.extentBefore} /  ${metrics.extentAfter}');

          return false;
        });
  }

  void getData() {
    //Initial data source
    for (var i = 0; i < 20; i++) {
      _items.insert(_items.length, 'original data ${_items.length}');
      print(_items[i]);
    }
  }

  void _onLoad() {
    Future<void>.delayed(const Duration(seconds: 2)).then((e) {
      for (var i = 0; i < 20; i++) {
        _items.insert(_items.length, 'loaded data ${_items.length}');
      }
      _loading = false;
      setState(() {});
    });
  }

  Future _onRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        //_mPage = 0;
        _items.clear();
        for (var i = 0; i < 20; i++) {
          _items.insert(_items.length, 'refreshed data ${_items.length}');
        }
      });
    });
  }

  @override
  void dispose() {
    //Remove monitoring to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }
}

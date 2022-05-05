import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotificationListener',
      home: Scaffold(
        appBar: AppBar(title: const Text('NotificationListener')),
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
  final _items = <String>[];
  var _lock = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        child: ListView.separated(
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

          //print('${metrics.extentBefore} /  ${metrics.extentAfter}');

          if (metrics.extentBefore == 0.0 &&
              metrics.extentAfter > 600.0 &&
              !_lock) {
            _lock = true;
            _onRefresh();
          }
          if (metrics.extentBefore > 600.0 &&
              metrics.extentAfter == 0.0 &&
              !_lock) {
            _lock = true;
            _onLoad();
          }

          return false;
        });
  }

  void initData() {
    for (var i = 0; i < 20; i++) {
      _items.insert(_items.length, 'original data ${_items.length}');
    }
  }

  void _onLoad() {
    Future<void>.delayed(const Duration(seconds: 2)).then((e) {
      print('_onLoad');
      for (var i = 0; i < 20; i++) {
        _items.insert(_items.length, 'loaded data ${_items.length}');
      }
      setState(() {});
      _lock = false;
    });
  }

  Future _onRefresh() async {
    print('_onRefresh');
    await Future<void>.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        _items.clear();
        for (var i = 0; i < 20; i++) {
          _items.insert(_items.length, 'refreshed data ${_items.length}');
        }
        _lock = false;
      });
    });
  }
}

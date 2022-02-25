import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return _ListViewState();
  }
}

class _ListViewState extends State {
  final ScrollController _controller = ScrollController();
  final _items = <String>[];
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ListView Demo'),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _refreshController,
          child: ListView.separated(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(title: Text('${_items[index]}'));
              },
              //Split line constructor
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.blue,
                );
              },
              itemCount: _items.length),
        ),
      ),
    );
  }

  void getData() {
    for (var i = 0; i < 20; i++) {
      _items.insert(_items.length, 'article ${_items.length} of original data');
      print(_items[i]);
    }
  }

  Future _onRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        //_mPage = 0;
        _items.clear();
        for (var i = 0; i < 20; i++) {
          _items.insert(
              _items.length, 'drop-down refreshed data in ${_items.length}');
        }
      });
    });
    _refreshController.refreshCompleted();
  }

  Future _onLoading() async {
    await Future<void>.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        for (var i = 0; i < 20; i++) {
          _items.insert(
              _items.length, 'this is the newly loaded ${_items.length} data');
        }
      });
    });
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    //Remove monitoring to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }
}

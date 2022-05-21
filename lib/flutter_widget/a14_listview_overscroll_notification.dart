import 'dart:developer';

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

class _MyListViewPageState extends State with TickerProviderStateMixin {
  final _items = <String>[];

  bool _loadingStatus = false;
  AnimationStatus _popupStatus = AnimationStatus.dismissed;
  bool _isActiveUpperSide = false;

  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _onInit();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurveTween(
      curve: Curves.easeInCubic,
    ).animate(_animationController);

    _animationController.addStatusListener((status) {
      _popupStatus = status;
      if (status == AnimationStatus.dismissed) {
        //stopped at the beginning
        // print('dismissed');
      } else if (status == AnimationStatus.forward) {
        // print('forward');
      } else if (status == AnimationStatus.completed) {
        //stopped at the end
        print('completed');
        Future<void>.delayed(const Duration(seconds: 1)).then((e) {
          setState(() {
            print('popdown');
            _animationController.reverse();
          });
        });
      } else if (status == AnimationStatus.reverse) {
        // print('reverse');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
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
              final max = notification.metrics.maxScrollExtent;

              //print('${metrics.extentBefore} /  ${metrics.extentAfter}');
              //print(notification.toString());

              if (notification is ScrollEndNotification &&
                  metrics.extentAfter == max &&
                  _popupStatus == AnimationStatus.dismissed) {
                _isActiveUpperSide = true;
                setState(() {
                  _animationController.forward();
                });
                _onRefresh();
              }
              if (notification is ScrollEndNotification &&
                  metrics.extentBefore == max &&
                  _popupStatus == AnimationStatus.dismissed) {
                _isActiveUpperSide = false;
                setState(() {
                  _animationController.forward();
                });
              }

              return false;
            }),
        Visibility(
          visible: _isActiveUpperSide && !_loadingStatus,
          child: AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return Positioned(
                  left: 0,
                  top: 0,
                  width: deviceWidth,
                  height: 100 * (_animation.value as double),
                  child: Align(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          log('_loadingStatus = true');
                          _loadingStatus = true;
                          _animationController.reset();
                        });
                        await _onRefresh();
                        setState(() {
                          log('_loadingStatus = false');
                          _loadingStatus = false;
                        });
                      },
                      child: const Text('最新記事を表示'),
                    ),
                  ),
                );
              }),
        ),
        Visibility(
          visible: !_isActiveUpperSide && !_loadingStatus,
          child: AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return Positioned(
                    left: 0,
                    bottom: 0,
                    width: deviceWidth,
                    height: 100 * (_animation.value as double),
                    child: Align(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            log('_loadingStatus = true', time: DateTime.now());
                            _loadingStatus = true;
                            _animationController.reset();
                          });
                          await _onLoad();
                          setState(() {
                            log('_loadingStatus = false', time: DateTime.now());
                            _loadingStatus = false;
                          });
                        },
                        child: const Text('次の20件を表示'),
                      ),
                    ));
              }),
        ),
        Visibility(
          visible: _isActiveUpperSide && _loadingStatus,
          child: const Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator()),
        ),
        Visibility(
          visible: !_isActiveUpperSide && _loadingStatus,
          child: const Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator()),
        ),
      ],
    );
  }

  void _onInit() {
    for (var i = 0; i < 20; i++) {
      _items.insert(_items.length, 'original data ${_items.length}');
    }
  }

  Future<void> _onLoad() async {
    log('_onLoad:start', time: DateTime.now());
    await Future<void>.delayed(const Duration(seconds: 3)).then((e) {
      for (var i = 0; i < 20; i++) {
        _items.insert(_items.length, 'loaded data ${_items.length}');
      }
    });
    log('_onLoad:end', time: DateTime.now());
  }

  Future<void> _onRefresh() async {
    log('_onRefresh:start', time: DateTime.now());
    await Future<void>.delayed(const Duration(seconds: 3)).then((e) {
      _items.clear();
      for (var i = 0; i < 20; i++) {
        _items.insert(_items.length, 'refreshed data ${_items.length}');
      }
    });
    log('_onRefresh:end', time: DateTime.now());
  }
}

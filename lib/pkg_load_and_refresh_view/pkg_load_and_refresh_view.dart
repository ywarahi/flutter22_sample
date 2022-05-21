import 'dart:developer';

import 'package:flutter/material.dart';

typedef FutureCallback = Future<void> Function();

class LoadAndRefreshViewController {
  //reserved
}

class LoadAndRefreshView extends StatefulWidget {
  const LoadAndRefreshView(
      this.child, this.onInit, this.onRefresh, this.onLoading, this.controller,
      {Key? key})
      : super(key: key);

  final Widget child;
  final FutureCallback onInit;
  final FutureCallback onRefresh;
  final FutureCallback onLoading;
  final LoadAndRefreshViewController controller;

  @override
  State createState() {
    return _LoadAndRefreshViewState();
  }
}

class _LoadAndRefreshViewState extends State<LoadAndRefreshView>
    with TickerProviderStateMixin {
  bool _loadingStatus = false;
  AnimationStatus _popupStatus = AnimationStatus.dismissed;
  bool _isActiveUpperSide = false;

  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    widget.onInit();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = CurveTween(
      curve: Curves.elasticOut //easeInCubic,
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
            child: widget.child,
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
                        await widget.onRefresh();
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
                          await widget.onLoading();
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
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter22_sample/pkg_load_and_refresh_view/pkg_load_and_refresh_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataListCNProvider = ChangeNotifierProvider<FeedListChangeNotifier>(
    (ref) => FeedListChangeNotifier());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfiniteScrollTabView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('InfiniteScrollTabView Demo'),
        ),
        body: Consumer(builder: (context, watch, child) {
          final notifier = context.read(dataListCNProvider.notifier); //watch不要
          final dataList = watch(dataListCNProvider); //watchしないと更新されない

          log('LoadAndRefreshView $dataList.dataList.last');

          return LoadAndRefreshView(
            ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(title: Text('${dataList.dataList[index]}'));
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.blue,
                  );
                },
                itemCount: dataList.dataList.length),
            notifier.initialize,
            notifier.refreshing,
            notifier.loading,
            LoadAndRefreshViewController(), //_refreshController,
          );
        }),
      ),
    );
  }
}

class FeedListChangeNotifier extends ChangeNotifier {
  FeedListChangeNotifier() {
    initialize();
  }

  List<int> dataList = <int>[];

  Future<void> initialize() async {
    log('initialize');

    dataList = <int>[];
    for (var i = 0; i < 20; i++) {
      dataList.insert(dataList.length, i);
    }
  }

  Future<void> refreshing() async {
    log('refreshing: start');

    await Future<void>.delayed(const Duration(seconds: 2)).then((e) {
      if (dataList.isNotEmpty) {
        final end = dataList.last;
        dataList = <int>[];
        for (var i = 0; i < 21; i++) {
          dataList.insert(dataList.length, end + 100 + i);
        }
      } else {
        initialize();
      }
    });
    notifyListeners();

    log('refreshing: end');
  }

  Future<void> loading() async {
    log('loading: start');

    await Future<void>.delayed(const Duration(seconds: 2)).then((e) {
      if (dataList.isNotEmpty) {
        final end = dataList.last;
        for (var i = 0; i < 20; i++) {
          dataList.insert(dataList.length, end + i + 1);
        }
        notifyListeners();
      } else {
        initialize();
      }
    });
    notifyListeners();

    log('loading: end');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter22_sample/pkg_load_and_refresh_view/pkg_load_and_refresh_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        body: LoadAndRefreshView(),
      ),
    );
  }
}

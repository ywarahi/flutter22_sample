import 'package:flutter/material.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';

final topTabItems = <Text>[
  const Text('1'),
  const Text('22'),
  const Text('333'),
  const Text('444'),
  const Text('55'),
  const Text('6'),
];

final topTabPages = <Widget>[
  const CustomPage(panelColor: Colors.cyan, title: '1'),
  const CustomPage(panelColor: Colors.green, title: '22'),
  const CustomPage(panelColor: Colors.pink, title: '333'),
  const CustomPage(panelColor: Colors.cyan, title: '444'),
  const CustomPage(panelColor: Colors.green, title: '55'),
  const CustomPage(panelColor: Colors.pink, title: '6')
];

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
        body: const _Content(),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  __ContentState createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    return InfiniteScrollTabView(
      contentLength: topTabItems.length,
      onTabTap: (index) {
        debugPrint('tapped $index');
      },
      tabBuilder: (index, isSelected) => topTabItems[index],
      separator: const BorderSide(color: Colors.black12, width: 2.0),
      onPageChanged: (index) => debugPrint('page changed to $index.'),
      indicatorColor: Colors.pink,
      pageBuilder: (context, index, _) {
        return topTabPages[index];
      },
    );
  }
}

class CustomPage extends StatelessWidget {
  const CustomPage({required this.panelColor, required this.title});

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


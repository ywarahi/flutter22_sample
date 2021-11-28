import 'package:flutter/material.dart';

// 複数のScaffold(path名付)を画面遷移メニューで遷移する

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp SAMPLE',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => RootPage(),
        '/welcome': (BuildContext context) => const BasePage('Welcome Page'),
        '/home': (BuildContext context) => const BasePage('Home Page'),
        '/settings': (BuildContext context) => const BasePage('Setting Page'),
      },
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget getListItem(String name, String path) {
      return ListTile(
        title: Text(name),
        onTap: () {
          //Navigator.pop(context);
          Navigator.of(context).pushNamed(path);
        },
      );
    }

    Widget getListView() {
      return ListView(
        children: [
          getListItem('/welcome', '/welcome'),
          getListItem('/home', '/home'),
          getListItem('/settings', '/settings'),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Root Page'),
      ),
      body: getListView(),
      drawer: Drawer(
        child: getListView(),
      ),
    );
  }
}

class BasePage extends StatelessWidget {
  const BasePage(this._title);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Text(_title),
    );
  }
}

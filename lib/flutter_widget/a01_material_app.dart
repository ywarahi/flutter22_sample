import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp SAMPLE',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => RootPage(),
        '/welcome': (BuildContext context) => WelcomePage(),
        '/home': (BuildContext context) => HomePage(),
        '/settings': (BuildContext context) => SettingsPage(),
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
          getListItem('/welcome','/welcome'),
          getListItem('/home','/home'),
          getListItem('/settings','/settings'),
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

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WelcomePage'),
      ),
      body: const Text('WelcomePage'),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: const Text('HomePage'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsPage'),
      ),
      body: const Text('SettingsPage'),
    );
  }
}

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAnmatedPage(),
    );
  }
}

class MyAnmatedPage extends StatefulWidget {
  const MyAnmatedPage({Key? key}) : super(key: key);

  @override
  _MyAnmatedPageState createState() => _MyAnmatedPageState();
}

class _MyAnmatedPageState extends State<MyAnmatedPage> with TickerProviderStateMixin {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
                opacity: flag ? 0.0 : 1.0,
                duration: const Duration(seconds: 3),
                child: Text(
                  '消える文字(0 ⇨ 1)',
                  style: Theme.of(context).textTheme.headline4,
                )),
            AnimatedOpacity(
                opacity: flag ? 1.0 : 0.0,
                duration: const Duration(seconds: 3),
                child: Text(
                  '消える文字(1 ⇨ 0)',
                  style: Theme.of(context).textTheme.headline4,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.blue,
                  iconSize: 32,
                ),
                const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.stop),
                  color: Colors.pink,
                  iconSize: 32,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  icon: const Icon(Icons.arrow_forward),
                  color: Colors.blue,
                  iconSize: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

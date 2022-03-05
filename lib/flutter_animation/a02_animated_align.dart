import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Animated Widget'),
      ),
      body: const MyAnimatedPage(),
    ));
  }
}

class MyAnimatedPage extends StatefulWidget {
  const MyAnimatedPage({Key? key}) : super(key: key);

  @override
  _MyAnimatedPageState createState() => _MyAnimatedPageState();
}

class _MyAnimatedPageState extends State<MyAnimatedPage>
    with TickerProviderStateMixin {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          createField(
              Colors.black26,
              AnimatedAlign(
                  duration: const Duration(seconds: 3),
                  alignment:
                      flag ? Alignment.centerLeft : Alignment.centerRight,
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Container(color: Colors.blue)))),
          createField(
              Colors.black12,
              AnimatedAlign(
                  duration: const Duration(seconds: 3),
                  alignment:
                      flag ? Alignment.topCenter : Alignment.bottomCenter,
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Container(color: Colors.blue)))),
          createField(
              Colors.black26,
              AnimatedAlign(
                  duration: const Duration(seconds: 3),
                  alignment: flag ? Alignment.topLeft : Alignment.bottomRight,
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Container(color: Colors.blue)))),
          createField(
              Colors.black12,
              AnimatedAlign(
                  duration: const Duration(seconds: 3),
                  alignment: flag ? Alignment.topRight : Alignment.bottomLeft,
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Container(color: Colors.blue)))),
          buildControlButtons(),
        ],
      ),
    );
  }

  Widget createField(Color background, Widget child, {double height = 150}) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Container(
        color: background,
        child: child,
      ),
    );
  }

  Widget buildControlButtons() {
    return Row(
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
    );
  }
}

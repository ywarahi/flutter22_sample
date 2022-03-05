import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// ①StateでAnimationを生成 & TickerProviderStateMixinを適用
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool flag = false;

  // ②AnimationControllerを定義
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // ③initStateでAnimationControllerを初期化（thisを使用しているため）
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    // ④disposeでAnimationControllerを破棄
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Widget'),
      ),
      body: Center(
        // ⑤AnimatedWidgetを作成
        child: AlignTransition(
          alignment: _animationController.drive(
            AlignmentTween(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton:
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
            onPressed: () {_animationController.forward();},
            child: const Icon(Icons.arrow_forward)),
        FloatingActionButton(
            onPressed: () {_animationController.stop();},
            child: const Icon(Icons.stop)),
        FloatingActionButton(
            onPressed: () {_animationController.reverse();},
            child: const Icon(Icons.arrow_back)),
      ]),
    );
  }
}

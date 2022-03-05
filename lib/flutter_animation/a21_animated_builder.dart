import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAnimatedPage(),
    );
  }
}

class MyAnimatedPage extends StatefulWidget {
  const MyAnimatedPage({Key? key}) : super(key: key);

  @override
  _MyAnimatedPageState createState() => _MyAnimatedPageState();
}

// ①StateでAnimationを生成 & TickerProviderStateMixinを適用
class _MyAnimatedPageState extends State<MyAnimatedPage> with TickerProviderStateMixin {
  // ②AnimationControllerを定義
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    // ③initStateでAnimationControllerを初期化（thisを使用しているため）
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    final curvedAnimation =
        CurveTween(curve: Curves.bounceIn).animate(_animationController);
    _animation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_animationController);
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
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return SizedBox(
                width: 100,
                height: 100,
                child: Container(color: _animation.value as Color));
          },
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
            onPressed: () {
              _animationController.forward();
            },
            child: const Icon(Icons.arrow_forward)),
        FloatingActionButton(
            onPressed: () {
              _animationController.stop();
            },
            child: const Icon(Icons.stop)),
        FloatingActionButton(
            onPressed: () {
              _animationController.reverse();
            },
            child: const Icon(Icons.arrow_back)),
      ]),
    );
  }
}

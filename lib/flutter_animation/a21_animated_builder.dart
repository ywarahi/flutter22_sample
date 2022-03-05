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

// ①StateでAnimationを生成 & TickerProviderStateMixinを適用
class _MyAnimatedPageState extends State<MyAnimatedPage>
    with TickerProviderStateMixin {
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

    // final curvedAnimation =
    //     CurveTween(curve: Curves.bounceIn).animate(_animationController);
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

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _animationController.reverse();
            });
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
          iconSize: 32,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _animationController.stop();
            });
          },
          icon: const Icon(Icons.stop),
          color: Colors.pink,
          iconSize: 32,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _animationController.forward();
            });
          },
          icon: const Icon(Icons.arrow_forward),
          color: Colors.blue,
          iconSize: 32,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          child: _buildControlButtons(),
        ),
        Container(
          alignment: Alignment.center,
          child: buildAnimatedWidget(),
        ),
      ],
    );
  }

  Widget buildAnimatedWidget() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return SizedBox(
            width: 100,
            height: 100,
            child: Container(color: _animation.value as Color));
      },
    );
  }
}

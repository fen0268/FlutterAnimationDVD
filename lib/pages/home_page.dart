import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_sample_app/utils/vector_branch.dart';
import 'package:flutter_animation_sample_app/utils/vector_forward.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Size deviceSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    deviceSize = MediaQuery.of(context).size;

    /// ３秒間でアニメーション
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    /// ランダムで デバイスの縦横の値 × 0.8 の値 を取得
    var randomWidth = Random().nextDouble() * deviceSize.width * 0.8;
    var randomHeight = Random().nextDouble() * deviceSize.height * 0.8;

    /// ベクトルの向きの４方向をランダムで取得
    /// 0 => 右上, 1 => 左上, 2 => 左下, 3 => 右下
    var randomVector = Random().nextInt(4);

    _offsetAnimation = Tween<Offset>(
      begin: Offset(randomWidth, randomHeight),
      end: Offset(
        randomWidth +
            VectorForward(
              vectorBranchX(randomVector),
              vectorBranchY(randomVector),
            ).x,
        randomHeight +
            VectorForward(
              vectorBranchX(randomVector),
              vectorBranchY(randomVector),
            ).y,
      ),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _offsetAnimation,
          key: GlobalKey(),
          child: const Text(
            "DVD",
            style: TextStyle(fontSize: 40),
          ),
          builder: (context, _) {
            return Transform.translate(
              offset: _offsetAnimation.value,
              child: _,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.reset();
            _offsetAnimation.removeStatusListener((status) {});
            didChangeDependencies();
          });
        },
      ),
    );
  }
}

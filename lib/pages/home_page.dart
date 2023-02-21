import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_sample_app/utils/vector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  /// ベクトルの向きの４方向をランダムで取得
  /// 0 => 右上, 1 => 左上, 2 => 左下, 3 => 右下
  final randomVector = Random().nextInt(4);
  late var vector = vectors(randomVector);
  late Size deviceLength;
  var location = const Offset(100, 110);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    deviceLength = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addPosition() async {
    while (true) {
      /// 上
      if (location.dy <= 0 && vector == vectors(0)) {
        vector = vectors(3);
        setState(() {});
      } else if (location.dy <= 0 && vector == vectors(1)) {
        vector = vectors(2);
        setState(() {});
      }

      /// 左
      if (location.dx <= 0 && vector == vectors(1)) {
        setState(() {});
        vector = vectors(0);
      } else if (location.dx <= 0 && vector == vectors(2)) {
        setState(() {});
        vector = vectors(3);
      }

      /// 下
      if (location.dy >= deviceLength.height - 60 && vector == vectors(3)) {
        setState(() {});
        vector = vectors(0);
      } else if (location.dy >= deviceLength.height - 60 &&
          vector == vectors(2)) {
        setState(() {});
        vector = vectors(1);
      }

      /// 右
      if (location.dx >= deviceLength.width - 65 && vector == vectors(0)) {
        setState(() {});
        vector = vectors(1);
      } else if (location.dx >= deviceLength.width - 65 &&
          vector == vectors(3)) {
        setState(() {});
        vector = vectors(2);
      }
      await Future.delayed(const Duration(milliseconds: 10));
      setState(() {
        location += vector;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: location.dy,
              left: location.dx,
              child: const Text(
                'DVD',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addPosition();
          });
        },
      ),
    );
  }
}

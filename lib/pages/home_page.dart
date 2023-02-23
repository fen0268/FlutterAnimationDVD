import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_sample_app/pages/setting_page.dart';
import 'package:flutter_animation_sample_app/utils/vector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  /// ベクトルの向きの４方向をランダムで取得
  /// 0 => 右上, 1 => 左上, 2 => 左下, 3 => 右下
  final randomVector = Random().nextInt(4);
  late var vector = vectors(randomVector);
  late Size deviceLength;
  var location = const Offset(110, 110);
  GlobalKey textKey = GlobalKey();
  var textSize = const Size(60, 60);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    deviceLength = MediaQuery.of(context).size;
    await Future.delayed(const Duration(milliseconds: 500));
    addPosition();
    getPosition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getPosition() {
    final box = textKey.currentContext!.findRenderObject() as RenderBox?;
    textSize = box!.size;
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
      if (location.dy >= deviceLength.height - textSize.height &&
          vector == vectors(3)) {
        setState(() {});
        vector = vectors(0);
      } else if (location.dy >= deviceLength.height - textSize.height &&
          vector == vectors(2)) {
        setState(() {});
        vector = vectors(1);
      }

      /// 右
      if (location.dx >= deviceLength.width - textSize.width &&
          vector == vectors(0)) {
        setState(() {});
        vector = vectors(1);
      } else if (location.dx >= deviceLength.width - textSize.width &&
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
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SettingPage(),
              ),
            );
          },
          child: Stack(
            children: [
              Positioned(
                top: location.dy,
                left: location.dx,
                child: Text(
                  'DVD',
                  style: const TextStyle(fontSize: 60),
                  key: textKey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

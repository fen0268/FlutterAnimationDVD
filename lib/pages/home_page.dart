import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Offset vector = const Offset(10, 10);
  var location = const Offset(100, 100);

  void a() async {
    while (true) {
      Future.delayed(const Duration(milliseconds: 160));
      setState(() {
        location += vector;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: location.dx,
            left: location.dy,
            child: const Text('DVD'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            a();
          });
        },
      ),
    );
  }
}

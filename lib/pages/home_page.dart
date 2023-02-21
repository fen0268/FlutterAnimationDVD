import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Offset vector = const Offset(1, -1);
  var location = const Offset(1, 110);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addPosition() async {
    while (true) {
      if (location.dy == 0) {
        setState(() {
          
        });
        vector = const Offset(1, 1);
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

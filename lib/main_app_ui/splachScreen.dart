import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/screens/acceuil-screen.dart';




import '../auth.dart';
import '../database/database_service.dart';
import '../monitoring_service/utils/flutter_background_service_utils.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 5),
      () => Get.off(() => Auth(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 400)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RollingImages(), // Custom widget for rolling image circles
            ],
          ),
        ),
      ),
    );
  }
}

class RollingImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RollImage(imagePath: "images/circle.png", index: 0),
        SizedBox(width: 10),
        RollImage(imagePath: "images/circle.png", index: 1),
        SizedBox(width: 10),
        RollImage(imagePath: "images/circle.png", index: 2),
      ],
    );
  }
}

class RollImage extends StatefulWidget {
  final String imagePath;
  final int index;

  RollImage({required this.imagePath, required this.index});

  @override
  _RollImageState createState() => _RollImageState();
}

class _RollImageState extends State<RollImage> {
  double _angle = 0;
  double _rollingSpeed = 100; // Adjust the rolling speed as needed
  double _startAngle = 0;
  double _rotationDirection = 1; // 1 for clockwise, -1 for counterclockwise

  @override
  void initState() {
    super.initState();
    _startAngle =
        Random().nextDouble() * 2 * pi; // Randomize the starting angle
    _rotationDirection =
        1 == 1 ? -1 : 1; // Reverse rotation for the middle circle
    _startRollingAnimation();
  }

  void _startRollingAnimation() {
    Future.delayed(Duration.zero, () {
      _animateImage();
    });
  }

  void _animateImage() {
    Future.delayed(Duration(milliseconds: (600 / _rollingSpeed).round()), () {
      if (mounted) {
        setState(() {
          _angle +=
              0.05 * _rotationDirection; // Adjust the rotation speed as needed
        });
        _animateImage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _startAngle + _angle,
      child: Image.asset(
        widget.imagePath,
        width: 45, // Adjust the width and height as needed
        height: 45,
      ),
    );
  }
}

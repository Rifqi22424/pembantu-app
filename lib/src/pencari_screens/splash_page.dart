// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key});

  @override
  Widget build(BuildContext context) {
    _delayAndPush(context);

    return Scaffold(
      body: _splashImages(),
    );
  }

  void _delayAndPush(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  Widget _splashImages() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/splashImages.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prt/src/screens/welcome_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    _delayAndPush(context);

    return Scaffold(
      body: _splashImages(),
    );
  }

  Future<Null> _delayAndPush(BuildContext context) {
    return Future.delayed(
    Duration(seconds: 3),
    () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomePage()));
    }
  );
  }

  Container _splashImages() {
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

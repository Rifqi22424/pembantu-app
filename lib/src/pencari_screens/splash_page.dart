// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../database/shared_preferences.dart';

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
    Future.delayed(Duration(milliseconds: 1000), () async {
      String? userToken = await getTokenFromSharedPreferences();
      String? role = await getRoleFromSharedPreferences();
      print(role);
      if (userToken == null || userToken == 'deleted') {
        Navigator.pushReplacementNamed(context, '/welcome');
      } else {
        if (role == 'majikan') {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/homepekerja');
        }
      }
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

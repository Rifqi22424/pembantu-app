// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class LoginRegistPage extends StatelessWidget {
  const LoginRegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          width: deviceTypeTablet() ? 340 : screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              _backgroundImages(),
              _whiteArea(context),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _whiteArea(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _greyLine(),
                _selamatDatang(),
                SizedBox(height: 16),
                _longText(),
                SizedBox(height: 32),
                _loginButton(context),
                SizedBox(height: 12),
                _signUpButton(context),
                SizedBox(height: screenHeight * 0.02)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _signUpButton(context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/regist');
      },
      child: Text(
        'Sign Up',
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF5F5F5)),
          minimumSize:
              MaterialStateProperty.all<Size>(Size(double.maxFinite, 44))),
    ));
  }

  Center _loginButton(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF38800C)),
          minimumSize:
              MaterialStateProperty.all<Size>(Size(double.maxFinite, 44))),
    ));
  }

  _longText() {
    return Text(
      'Kami senang melihat kamu lagi, untuk menggunakan akun , masuk terlebih dahulu',
      style: TextStyle(
        color: Color(0xFF828892),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.70,
      ),
    );
  }

  _selamatDatang() {
    return Text(
      'Selamat Datang 👋',
      style: TextStyle(
        color: Color(0xFF080B11),
        fontSize: 22,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  _greyLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          width: 64,
          height: 4,
          decoration: ShapeDecoration(
            color: Color(0xFFF3F3F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Container _backgroundImages() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        image: DecorationImage(
          image: AssetImage('images/mother.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

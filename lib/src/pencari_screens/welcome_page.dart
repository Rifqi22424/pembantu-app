// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
                _button(context),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _button(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/loginregist');
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          backgroundColor: Color(0xFF38800C),
          minimumSize: Size(double.maxFinite, 44),
        ),
        child: Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  _longText() {
    return Text(
      'Kami Senang melihat-mu apakah anda membutuhkan pembantu rumah tangga atau ingin bekerja menjadi pembantu ? Klik Next',
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

  Padding _greyLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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

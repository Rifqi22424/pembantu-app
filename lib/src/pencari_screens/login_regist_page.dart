// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/text_styles.dart';

class LoginRegistPage extends StatefulWidget {
  const LoginRegistPage({super.key});

  @override
  State<LoginRegistPage> createState() => _LoginRegistPageState();
}

class _LoginRegistPageState extends State<LoginRegistPage>
    with SingleTickerProviderStateMixin {
  bool _isDragged = false;
  double _top = 760;
  late AnimationController _animationController;
  late Animation<double> _animation;

  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
    );
    _animation = Tween<double>(
      begin: _top,
      end: 760,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
      // top: _top,
      child: GestureDetector(
        onVerticalDragDown: (details) {
          _isDragged = true;
        },
        onVerticalDragUpdate: (details) {
          double bottomLimit = 760;
          setState(() {
            _top += details.primaryDelta! * 1;
            if (_top > bottomLimit) {
              _top = bottomLimit;
            }
          });
        },
        onVerticalDragEnd: (details) {
          setState(() {
            _isDragged = false;
            _animation = Tween<double>(
              begin: _top,
              end: 760,
            ).animate(_animationController)
              ..addListener(() {
                setState(() {
                  _top = _animation.value;
                });
              });
            _animationController.reset();
            _animationController.forward();
          });
        },
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
      style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFF5F5F5)),
          minimumSize:
              WidgetStateProperty.all<Size>(Size(double.maxFinite, 54))),
      child: Text('Sign Up', style: TextStyles.greyButton),
    ));
  }

  Center _loginButton(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
          minimumSize:
              WidgetStateProperty.all<Size>(Size(double.maxFinite, 54))),
      child: Text('Login', style: TextStyles.button),
    ));
  }

  _longText() {
    return Text(
        'Kami senang melihat kamu lagi, untuk menggunakan akun, masuk terlebih dahulu',
        style: TextStyles.regularText);
  }

  _selamatDatang() {
    return Text('Selamat Datang 👋', style: TextStyles.welcomeTitle);
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

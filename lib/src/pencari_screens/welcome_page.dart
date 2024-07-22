// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/text_styles.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  bool _isDragged = false;
  double _top = 350;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
    );
    _animation = Tween<double>(
      begin: _top,
      end: 350,
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
      body: SizedBox(
        width: deviceTypeTablet() ? 340 : screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            _backgroundImages(),      
            _whiteArea(context),
          ],
        ),
      ),
    );
  }

  _whiteArea(BuildContext context) {
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
          double bottomLimit = 350;
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
              end: 350,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
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
            ],
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
          minimumSize: Size(double.maxFinite, 54),
        ),
        child: Text('Next', style: TextStyles.button),
      ),
    );
  }

  _longText() {
    return Text(
        'Kami Senang melihat-mu apakah anda membutuhkan pembantu rumah tangga atau ingin bekerja menjadi pembantu ? Klik Next',
        style: TextStyles.regularText);
  }

  _selamatDatang() {
    return Text('Selamat Datang 👋', style: TextStyles.welcomeTitle);
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

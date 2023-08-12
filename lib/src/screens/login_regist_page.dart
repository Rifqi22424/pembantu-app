import 'package:flutter/material.dart';
import 'package:prt/src/screens/choose_page.dart';
import 'package:prt/src/screens/login_page.dart';

class LoginRegistPage extends StatelessWidget {
  const LoginRegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundImages(),
          _whiteArea(context),
        ],
      ),
    );
  }

  Positioned _whiteArea(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 355,
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _greyLine(),
            _selamatDatang(),
            SizedBox(height: 12),
            _longText(),
            SizedBox(height: 32),
            _loginButton(context),
            SizedBox(height: 12),
            _signUpButton(context),
          ],
        ),
      ),
    );
  }

  Center _signUpButton(context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChoosePage()));
      },
      child: Text(
        'Sign Up',
        style: TextStyle(
          color: Color(0xFF828993),
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF5F5F5)),
          minimumSize: MaterialStateProperty.all<Size>(Size(320, 50))),
    ));
  }

  Center _loginButton(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Text('Login'),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF38800C)),
          minimumSize: MaterialStateProperty.all<Size>(Size(320, 50))),
    ));
  }

  Padding _longText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Kami senang melihat kamu lagi, untuk menggunakan akun , masuk terlebih dahulu',
        style: TextStyle(
          color: Color(0xFF828892),
          fontSize: 12.5,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.70,
        ),
      ),
    );
  }

  Padding _selamatDatang() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Selamat Datang 👋',
        style: TextStyle(
          color: Color(0xFF080B11),
          fontSize: 22,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w600,
        ),
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

import 'package:flutter/material.dart';
import 'package:prt/src/screens/login_regist_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
        height: 310,
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
            _button(context),
          ],
        ),
      ),
    );
  }

  Center _button(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginRegistPage(),
            ),
          );
        },
        child: Text('Next'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          primary: Color(0xFF38800C),
          minimumSize: Size(320, 50),
        ),
      ),
    );
  }

  Padding _longText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Kami Senang melihat-mu apakah anda membutuhkan pembantu rumah tangga atau ingin bekerja menjadi pembantu ? Klik Next',
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

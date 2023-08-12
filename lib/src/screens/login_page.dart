import 'package:flutter/material.dart';
import 'package:prt/src/widgets/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelamatDatang(),
            LongText(),
            SizedBox(height: 108),
            LoginWidget(),
          ],
        ),
      ),
    );
  }

  Padding LongText() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 24),
      child: Container(
        child: Text(
          'Kami senang melihat kamu lagi, untuk menggunakan akun, masuk terlebih dahulu',
          style: TextStyle(
            color: Color(0xFF828892),
            fontSize: 12.5,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.70,
          ),
        ),
      ),
    );
  }

  Padding SelamatDatang() {
    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 24),
      child: Container(
        child: Text(
          'Selamat Datang 👋',
          style: TextStyle(
            color: Color(0xFF080B11),
            fontSize: 22,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

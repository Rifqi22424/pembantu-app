import 'package:flutter/material.dart';
import 'package:prt/src/widgets/regist_pencari_widget.dart';

class RegistPencari extends StatelessWidget {
  const RegistPencari({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopText(),
            SizedBox(height: 30),
            RegistPencariWidget(),
          ],
        ),
      ),
    );
  }
}

class TopText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang 👋',
              style: TextStyle(
                color: Color(0xFF080B11),
                fontSize: 22,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Kami senang melihat kamu, silahkan daftar terlebih dahulu',
              style: TextStyle(
                color: Color(0xFF828892),
                fontSize: 12.5,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

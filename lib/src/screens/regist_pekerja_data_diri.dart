import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:prt/src/widgets/regist_pekerja_data_diri_widget.dart';

class RegistPekerjaDataDiri extends StatelessWidget {
  const RegistPekerjaDataDiri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TopText(), checklist(), RegistPekerjaDataDiriWidget()],
        ),
      ),
    );
  }

  Padding checklist() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset('images/filCheck.png'),
                  Text(
                    'Data Diri',
                    style: TextStyle(
                      color: Color(0xFF828892),
                      fontSize: 8,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                      height: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dash(
                dashColor: Color(0xFF828892),
                length: 40,
                dashLength: 8,
                dashGap: 2,
                direction: Axis.horizontal,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Image.asset('images/emptyCheck.png'),
                  Text(
                    'Keterangan',
                    style: TextStyle(
                      color: Color(0xFF828892),
                      fontSize: 8,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dash(
                dashColor: Color(0xFF828892),
                length: 40,
                dashLength: 8,
                dashGap: 2,
                direction: Axis.horizontal,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Image.asset('images/emptyCheck.png'),
                  Text(
                    'Kontak Lain',
                    style: TextStyle(
                      color: Color(0xFF828892),
                      fontSize: 8,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dash(
                dashColor: Color(0xFF828892),
                length: 40,
                dashLength: 8,
                dashGap: 2,
                direction: Axis.horizontal,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Image.asset('images/emptyCheck.png'),
                  Text(
                    'Pengalaman',
                    style: TextStyle(
                      color: Color(0xFF828892),
                      fontSize: 8,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding TopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
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
              'Silahkan isi Data Diri Tentang anda dan penglaman Bekerja',
              style: TextStyle(
                color: Color(0xFF828892),
                fontSize: 12.5,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

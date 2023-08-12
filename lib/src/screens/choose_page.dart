import 'package:flutter/material.dart';
import 'package:prt/src/screens/regist_pekerja_data_diri.dart';
import 'package:prt/src/screens/regist_pencari.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  bool isBoxPekerjaPressed = false;
  bool isBoxPencariPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopText(),
          SizedBox(height: 40),
          BoxPekerja(context),
          SizedBox(height: 12),
          BoxPencari(context),
          SizedBox(height: 16),
          SubmitButton(),
        ],
      ),
    );
  }

  InkWell BoxPencari(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isBoxPencariPressed = !isBoxPencariPressed;
          isBoxPekerjaPressed = false;
        });
      },
      child: Container(
        width: 320,
        height: 220,
        padding: EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
          bottom: 16,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
                color: isBoxPencariPressed ? Colors.black : Colors.transparent,
                width: 2.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/Pencari.png',
              width: 70,
              height: 70,
            ),
            SizedBox(height: 5),
            Text(
              'Mencari Pekerja',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF080B11),
                fontSize: 14,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Kamu Bisa Mencari Pekerja yang sesuai dengan kebutuhan anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF828993),
                fontSize: 12,
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

  InkWell BoxPekerja(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isBoxPekerjaPressed = !isBoxPekerjaPressed;
          isBoxPencariPressed = false;
        });
      },
      child: Container(
        width: 320,
        height: 220,
        padding: EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
          bottom: 16,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: isBoxPekerjaPressed ? Colors.black : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/Pembantu.png',
              width: 70,
              height: 70,
            ),
            SizedBox(height: 5),
            Text(
              'Pekerja',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF080B11),
                fontSize: 14,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Cantumkan Profile data diri-Mu dan tunggu seseorang menghubungi-Mu',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF828993),
                fontSize: 12,
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

  ElevatedButton SubmitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: MaterialStateProperty.all<Size>(Size(320, 50)),
      ),
      onPressed: () {
        if (isBoxPekerjaPressed) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegistPekerjaDataDiri()));
        } else if (isBoxPencariPressed) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegistPencari()));
        }
      },
      child: Text('Selanjutnya'),
    );
  }

  Padding TopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih salah satu',
              style: TextStyle(
                color: Color(0xFF080B11),
                fontSize: 22,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'ingin sebagai Pencari Pembantu, atau sebagai Pembantu',
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

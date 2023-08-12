import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prt/src/screens/login_page.dart';
import 'package:prt/src/widgets/verif_widget.dart';

class VerifPage extends StatefulWidget {
  const VerifPage({Key? key}) : super(key: key);

  @override
  _VerifPageState createState() => _VerifPageState();
}

class _VerifPageState extends State<VerifPage> {
  bool _isVerifSuccess = false;
  bool _isCountdownActive = true;
  int _countdownSeconds = 30;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isVerifSuccess ? Colors.white.withOpacity(0.8) : Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopText(),
                SizedBox(height: 30),
                VerifCodeInput(
                  onVerificationSuccess: () {
                    _handleVerificationSuccess();
                  },
                ),
                SizedBox(height: 20),
                ResendCode(),
              ],
            ),
            if (_isVerifSuccess) overlaySuccessVerif(),
          ],
        ),
      ),
    );
  }

  Padding TopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 24, right: 24),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verifikasi No Anda',
              style: TextStyle(
                color: Color(0xFF080B11),
                fontSize: 22,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Verifikasi Code Lewat No. 08** **** **** **34, atau lewat ',
                    style: TextStyle(
                      color: Color(0xFF828993),
                      fontSize: 12.5,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                      text: 'cara lain',
                      style: TextStyle(
                        color: Color(0xFF38800C),
                        fontSize: 12.5,
                        fontFamily: 'Asap',
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ResendCode() {
    if (_isCountdownActive) {
      return Center(
        child: Text(
          'Kirim ulang code dalam 00:$_countdownSeconds',
          style: TextStyle(
              color: Color(0xFF828892),
              fontSize: 10,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
              height: 1.7),
        ),
      );
    } else {
      return Center(
        child: Text(
          'Kirim ulang code',
          style: TextStyle(
            color: Color(0xFF38800C),
            fontSize: 10,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
      );
    }
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          _isCountdownActive = false;
          _countdownSeconds = 30;
        }
      });

      if (_isCountdownActive) {
        _startCountdown();
      }
    });
  }

  void _handleVerificationSuccess() {
    setState(() {
      _isVerifSuccess = true;
    });
  }

  overlaySuccessVerif() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 220),
      child: Container(
        width: 300,
        height: 300,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.asset('images/check.png', width: 70, height: 70),
            Text(
              'Pendaftaran Anda Berhasil',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF00D65D),
                fontSize: 24,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Masuk ke akun anda sekarang',
              style: TextStyle(
                color: Color(0xFF828892),
                fontSize: 12.5,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF38800C)),
                minimumSize: MaterialStateProperty.all<Size>(Size(250, 50)),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}

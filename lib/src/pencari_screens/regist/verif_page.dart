// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _isVerifSuccess ? Colors.white.withOpacity(0.8) : Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 380,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.12),
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
            ),
          ),
          if (_isVerifSuccess) overlaySuccessVerif(),
        ],
      ),
    );
  }

  TopText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
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
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                    text: 'cara lain',
                    style: TextStyle(
                      color: Color(0xFF38800C),
                      fontSize: 12,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
              ],
            ),
          ),
        ],
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
    return Positioned.fill(
      child: Center(
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.only(right: 20, left: 20, top: 20),
            width: 300,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child:
                        Image.asset('images/xNoBG.png', width: 16, height: 16)),
                Image.asset('images/check.png', width: 70, height: 70),
                Text(
                  'Pendaftaran Anda Berhasil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF00D65D),
                    fontSize: 22,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Masuk ke akun anda sekarang',
                  style: TextStyle(
                    color: Color(0xFF828892),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF38800C)),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(double.maxFinite, 44)),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/choose');
                  },
                  child: Text(
                    'Selanjutnya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

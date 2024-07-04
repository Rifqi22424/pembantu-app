import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:vibration/vibration.dart';
import 'package:prt/src/database/shared_preferences.dart';

class IncomingVideoCall extends StatefulWidget {
  const IncomingVideoCall({Key? key}) : super(key: key);

  @override
  State<IncomingVideoCall> createState() => _InconmingVideoCallState();
}

class _InconmingVideoCallState extends State<IncomingVideoCall>
    with TickerProviderStateMixin {
  late Animation<double> callAnimation;
  late AnimationController callController;
  double _top = 100;
  double _minTop = 0.0;
  double _maxTop = 200.0;
  bool _isDragged = false;

  @override
  void initState() {
    super.initState();

    // Memutar dering
    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true,
      volume: 1.0,
      asAlarm: false,
    );

    Vibration.vibrate(pattern: [2000, 2000, 2000, 2000, 2000], repeat: 2);

    callController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    callAnimation = Tween(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: callController, curve: Curves.easeInOut),
    );

    startAnimation();
  }

  @override
  void dispose() {
    FlutterRingtonePlayer.stop();
    Vibration.cancel();
    callController.dispose();
    super.dispose();
  }

  void startAnimation() async {
    await callController.forward().whenComplete(() {});
    await callController.reverse().whenComplete(() {});
    await Future.delayed(Duration(seconds: 2));
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            incomingCallBG(),
            Container(
              alignment: Alignment.center,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0),
                  width: double.infinity,
                  height: double.infinity,
                  child: Container(),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: screenHeight,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    profilCalling(),
                    const SizedBox(height: 44),
                    nameCalling(),
                    const SizedBox(height: 12),
                    callStatue(),
                    SizedBox(height: 150),
                    Stack(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'images/nav_up_green.png',
                                width: 20,
                                height: 22,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Angkat',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Asap',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 130,
                                width: 60,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Tolak',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Asap',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Image.asset(
                                'images/nav_down_red.png',
                                width: 20,
                                height: 22,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onVerticalDragDown: (details) {
                              _isDragged = true;
                            },
                            onVerticalDragUpdate: (details) async {
                              final String? token =
                                  await getVcallTokenFromSharedPreferences();
                              final String? channel =
                                  await getVcallNameFromSharedPreferences();
                              setState(() {
                                _top += details.primaryDelta! *
                                    1.5; 
                                if (_top < _minTop) {
                                  _top = _minTop;
                                  Navigator.pushReplacementNamed(
                                      context, '/videocall',
                                      arguments: {
                                        'channel': channel,
                                        'token': token,
                                      });
                                  print('Batas atas');
                                  FlutterRingtonePlayer.stop();
                                  Vibration.cancel();
                                } else if (_top > _maxTop) {
                                  _top = _maxTop;
                                  Navigator.pop(context);
                                  FlutterRingtonePlayer.stop();
                                  Vibration.cancel();
                                  print('Batas bawah');
                                }
                              });
                            },
                            onVerticalDragEnd: (details) {
                              _isDragged = false;
                              resetToCenter();
                            },
                            child: AnimatedBuilder(
                              animation: callController,
                              builder: (context, child) {
                                if (!_isDragged) {
                                  return Transform.scale(
                                    scale: callAnimation.value,
                                    child: Transform.translate(
                                      offset: Offset(
                                        Random().nextBool() ? 0.5 : -0.5,
                                        0.0,
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 1000),
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: _top),
                                        child: Image.asset(
                                          'images/InterviewGreen.png',
                                          width: 60,
                                          height: 60,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  // Jika _isDragged == true, kembalikan widget tanpa animasi
                                  return Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: _top),
                                    child: Image.asset(
                                      'images/InterviewGreen.png',
                                      width: 60,
                                      height: 60,
                                    ),
                                  );
                                }
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetToCenter() {
    // Kembalikan widget ke posisi tengah dengan animasi
    setState(() {
      _top = (_maxTop - _minTop) / 2;
    });
  }

  Text callStatue() {
    return const Text(
      'Berdering',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 0,
      ),
    );
  }

  Text nameCalling() {
    return const Text(
      'Sephira Amelia',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
        height: 0,
      ),
    );
  }

  Container profilCalling() {
    return Container(
      width: 180,
      height: 180,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/incomingCallPhotoDumb.png'),
          ),
          shape: BoxShape.circle),
    );
  }

  Image border() {
    return Image.asset(
      'images/borderIncomingCall.png',
      width: 210,
      height: 210,
    );
  }

  incomingCallBG() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/incomingCallBG.png'),
              fit: BoxFit.cover)),
    );
  }
}

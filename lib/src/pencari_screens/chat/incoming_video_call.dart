import 'dart:ui';

import 'package:flutter/material.dart';

class InconmingVideoCall extends StatefulWidget {
  const InconmingVideoCall({super.key});

  @override
  State<InconmingVideoCall> createState() => _InconmingVideoCallState();
}

class _InconmingVideoCallState extends State<InconmingVideoCall>
    with TickerProviderStateMixin {
  late Animation<double> callAnimation;
  late AnimationController callController;

  @override
  void initState() {
    super.initState();

    callController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10),
    );

    callAnimation = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: callController, curve: Curves.easeInOut),
    );

    callController.repeat(reverse: true);
  }

  @override
  void dispose() {
    callController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
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
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        pickUpColumn(),
                        rejectColumn(),
                      ],
                    ),
                    SizedBox(height: 12),
                    swipeUp()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  swipeUp() {
    return Image.asset(
      'images/navUp.png',
      height: 40,
      width: 40,
    );
  }

  Column rejectColumn() {
    return Column(
      children: [
        Image.asset(
          'images/navUpDouble.png',
          width: 19,
          height: 22,
        ),
        SizedBox(height: 20),
        Image.asset(
          'images/rejectCall.png',
          width: 60,
          height: 60,
        ),
        SizedBox(height: 20),
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
      ],
    );
  }

  Column pickUpColumn() {
    return Column(
      children: [
        Image.asset(
          'images/navUpDouble.png',
          width: 19,
          height: 22,
        ),
        SizedBox(height: 20),
        Image.asset(
          'images/pickUpCall.png',
          width: 60,
          height: 60,
        ),
        SizedBox(height: 20),
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
      ],
    );
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

  // incomingCallBG() {
  //   return ImageFiltered(
  //     imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
  //     child: Image.asset(
  //       'images/incomingCallBG.png',
  //       fit: BoxFit.cover,
  //     ),
  //   );
  // }
}

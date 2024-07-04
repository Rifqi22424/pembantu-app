// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:prt/src/pencari_screens/transfer/struk_transfer_page.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class ConfirmPinPage extends StatefulWidget {
  const ConfirmPinPage({super.key});

  @override
  State<ConfirmPinPage> createState() => ConfirmPinPageState();
}

class ConfirmPinPageState extends State<ConfirmPinPage> {
  late FocusNode pinFocusNode;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pinFocusNode = FocusNode();
    pinFocusNode.requestFocus();
  }

  @override
  void dispose() {
    pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: deviceTypeTablet() ? 340 : screenWidth,
              child: Column(
                children: [
                  Stack(
                    children: [
                      title(),
                      back(context),
                    ],
                  ),
                  SizedBox(height: 60),
                  pinSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pinSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Masukan Pin Anda',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 15,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: 200,
          child: PinCodeTextField(
            pinTheme: PinTheme(
              selectedFillColor: Colors.black,
              selectedColor: Colors.black,
              activeColor: Colors.black,
              inactiveColor: Colors.black,
              shape: PinCodeFieldShape.circle,
              fieldHeight: 24,
              fieldWidth: 24,
            ),
            focusNode: pinFocusNode,
            obscureText: true,
            obscuringWidget: Container(
                decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            )),
            animationType: AnimationType.none,
            keyboardType: TextInputType.number,
            appContext: context,
            length: 4,
            controller: textEditingController,
            onChanged: (value) {},
            onCompleted: (value) {
              print("Completed: $value");
              if (textEditingController.text == "1234") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StrukTransferPage(),
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }

  Center title() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 60),
          child: Text(
            'Transfer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }

  back(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 60),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 30,
              height: 30,
              padding: EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Image.asset('images/NavBackTransparant.png'),
            ),
          ),
        ],
      ),
    );
  }
}

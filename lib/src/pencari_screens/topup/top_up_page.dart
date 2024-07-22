// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/mixins/thousand_formatter.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => TopUpPageState();
}

class TopUpPageState extends State<TopUpPage> {
  int? selectedPrice;
  bool isOverlayVisible = false;
  List<int> prices = [
    100000,
    500000,
    1000000,
    1500000,
    3000000,
    3500000,
    4000000,
    4500000,
    5000000,
  ];
  List<bool> containerStates = List.generate(9, (index) => false);
  TextEditingController topUpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: deviceTypeTablet() ? 340 : screenWidth,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isOverlayVisible = false;
                  });
                },
                child: Opacity(
                  opacity: isOverlayVisible ? 0.5 : 1.0,
                  child: AbsorbPointer(
                    absorbing: (isOverlayVisible) ? true : false,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            back(context),
                            title(),
                          ],
                        ),
                        topUpBox(),
                        SizedBox(height: 30),
                        topUpButton(),
                      ],
                    ),
                  ),
                ),
              ),
              if (isOverlayVisible) TopUpOverlay(context),
            ],
          ),
        ),
      ),
    );
  }

  Center title() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 65),
          child: Text(
            'Top Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }

  topUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
          minimumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 54)),
        ),
        onPressed: () {
          print(selectedPrice);
          if (selectedPrice == null) {
            _showTopSnackbar(context, 'Isi nominal top up!');
          } else if (selectedPrice! < 50000) {
            _showTopSnackbar(context, 'Minimal Top Up Rp. 50.000');
          } else {
            Navigator.pushNamed(context, '/paymethod',
                arguments: {'digitTopUp': selectedPrice});
          }
        },
        child: Text(
          'Top Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showTopSnackbar(BuildContext context, String text) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Color(0xFFFF2222), // Warna latar belakang
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  topUpBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 38, left: 24, right: 24),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/TopUpBG.png'), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topUpSebesarText(),
            SizedBox(height: 8),
            topUpInput(),
            line(),
            SizedBox(height: 12),
            chooseFastNominal(),
          ],
        ),
      ),
    );
  }

  GestureDetector chooseFastNominal() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOverlayVisible = true;
          FocusScope.of(context).unfocus();
        });
      },
      child: Text(
        'Pilih Nominal Cepat',
        style: TextStyle(
          color: Color(0xFF2B2B2B),
          fontSize: 10,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Divider line() {
    return Divider(
      height: 1,
      color: Color(0XFFE8E8E8),
    );
  }

  Row topUpInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Rp. ',
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 140,
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Isi Nominal',
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Color(0xFF080C11),
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
            controller: selectedPrice != null
                ? TextEditingController(
                    text: NumberFormat.decimalPattern('vi_VN')
                        .format(selectedPrice)
                        .toString())
                : topUpController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              NumberTextInputFormatter(),
            ],
            autofocus: true,
            onChanged: (String? value) {
              if (value != null && value.isNotEmpty) {
                selectedPrice = int.tryParse(value.replaceAll('.', '')) ?? 0;
              }
            },
          ),
        ),
      ],
    );
  }

  Text topUpSebesarText() {
    return Text(
      'Top Up Sebesar',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF2B2B2B),
        fontSize: 10,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
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

  TopUpOverlay(context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 400,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 2.0,
                spreadRadius: 0.0,
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _greyLine(),
            _titleOverlay(),
            Expanded(
              child: GridView(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 60,
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2, // Ubah sesuai kebutuhan Anda
                ),
                children: List.generate(9, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        for (int i = 0; i < containerStates.length; i++) {
                          containerStates[i] = false;
                        }
                        containerStates[index] = true;
                        selectedPrice = prices[index];
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: containerStates[index]
                            ? Color(0xFFECF3E7)
                            : Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rp. ',
                              style: TextStyle(
                                color: containerStates[index]
                                    ? Color(0xFF38800C)
                                    : Color(0xFF080C11),
                                fontSize: 12,
                                fontFamily: 'Asap',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              NumberFormat.decimalPattern('vi_VN')
                                  .format(prices[index]),
                              style: TextStyle(
                                color: containerStates[index]
                                    ? Color(0xFF38800C)
                                    : Color(0xFF080C11),
                                fontSize: 12,
                                fontFamily: 'Asap',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            _button(context),
          ],
        ),
      ),
    );
  }

  Center _button(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 16, left: 25, right: 25),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isOverlayVisible = false;
            });
          },
          child: Text(
            'Pilih',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            backgroundColor: Color(0xFF38800C),
            minimumSize: Size(double.maxFinite, 54),
          ),
        ),
      ),
    );
  }

  _titleOverlay() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: Center(
        child: Text(
          'Pilih Nominal',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
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
}

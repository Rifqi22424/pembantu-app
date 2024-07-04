// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/models/pay_method_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';

import '../../api/digital_money.dart';

class PayMethod extends StatefulWidget {
  final int digitTopUp;

  PayMethod({super.key, required this.digitTopUp});

  @override
  State<PayMethod> createState() => _PayMethodState();
}

class _PayMethodState extends State<PayMethod> {
  final DigitalMoney digitalMoney = DigitalMoney();
  bool isOverlayVisible = false;
  int selectedIndex = -1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: deviceTypeTablet() ? 340 : screenWidth,
          height: screenHeight,
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
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          back(context),
                          title(),
                          cancel(context),
                        ],
                      ),
                      InformationText(),
                      SizedBox(height: 24),
                      payMethodContent(context),
                      Spacer(),
                      button(),
                      SizedBox(height: 24)
                    ],
                  ),
                ),
              ),
              if (isOverlayVisible) PayMethodOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  payMethodContent(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: AssetImage('images/PayMethodDownBG.png'),
              fit: BoxFit.cover)),
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metode Pembayaran',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  isOverlayVisible = true;
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    selectedIndex == -1
                        ? 'images/wallet.png'
                        : methodList[selectedIndex].imageUrl,
                    width: 32,
                    height: 32,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedIndex == -1
                              ? 'Pilih Pembayaran'
                              : methodList[selectedIndex].nameBank,
                          style: TextStyle(
                            color: Color(0xFF2B2B2B),
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          'images/NavNext.png',
                          width: 20,
                          height: 20,
                        )
                      ],
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

  Padding InformationText() {
    return Padding(
      padding: const EdgeInsets.only(top: 34, left: 24, right: 24),
      child: Container(
        padding: EdgeInsets.only(top: 23, left: 24, right: 24, bottom: 26),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage('images/PayMethodBG.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah',
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Rp. ${NumberFormat.decimalPattern('vi_VN').format(widget.digitTopUp)}',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'PRT220623001',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(
              color: Color(0xFFE8E8E8),
              thickness: 2,
            ),
            SizedBox(height: 12),
            Text(
              'Nama Lengkap',
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Ana Blacklight',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Divider(
              color: Color(0xFFE8E8E8),
              thickness: 2,
            ),
            SizedBox(height: 12),
            Text(
              'Nomor Handphone',
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '+6289612313214',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Divider(
              color: Color(0xFFE8E8E8),
              thickness: 2,
            ),
            SizedBox(height: 12),
            Text(
              'Email',
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'anablacklight23@gmail.com',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  back(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 24),
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

  title() {
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

  cancel(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 24),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
          child: Container(
            width: 30,
            height: 30,
            padding: EdgeInsets.all(6),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Image.asset(
              'images/x.png',
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }

  button() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: WidgetStateProperty.all<Size>(Size(320, 44)),
      ),
      onPressed: () async {
        print(selectedIndex);
        if (selectedIndex == -1) {
          _showTopSnackbar(
              context, "Pilih metode pembayaran terlebih dahulu!", false);
        } else {
          int digitTopUp = widget.digitTopUp;
          int bankIndex = methodList[selectedIndex].selectedIndex;
          String bankImages = methodList[selectedIndex].imageUrl;
          String bankNames = methodList[selectedIndex].nameBank;

          print('$digitTopUp, $bankIndex, $bankImages, $bankNames');

          try {
            setState(() {
              isLoading = true;
            });
            bool success = await digitalMoney.topup(digitTopUp, bankIndex);
            if (success) {
              Navigator.pushNamed(context, '/struktopup', arguments: {
                'digitTopUp': digitTopUp,
                'bankIndex': bankIndex,
                'bankImages': bankImages,
                'bankNames': bankNames,
              });
              setState(() {
                isLoading = false;
              });
            }
          } catch (e) {
            print(e);

            _showTopSnackbar(
                context, e.toString().replaceFirst('Exception: ', ''), false);
            setState(() {
              isLoading = false;
            });
          }
        }
      },
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              'Top Up Sekarang',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  void _showTopSnackbar(BuildContext context, String label, bool isTrueColor) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: isTrueColor ? Color(0xFF39810D) : Color(0xFFFF2222),
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    label,
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

  PayMethodOverlay() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 300,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _greyLine(),
            _titleOverlay(),
            PayMethodList(),
          ],
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

  _titleOverlay() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: Center(
        child: Text(
          'Transfer Virtual Bank',
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

  PayMethodList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 6),
        itemCount: methodList.length,
        itemBuilder: (context, index) {
          final method = methodList[index];
          return PayMethodListItem(method, index);
        },
      ),
    );
  }

  PayMethodListItem(Method method, index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          for (var i = 0; i < methodList.length; i++) {
            methodList[i].isSelected = false;
          }
          method.isSelected = true;
          isOverlayVisible = false;
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Container(
          color: method.isSelected ? Color(0xFFF5F5F5) : Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(method.imageUrl),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14),
              Text(
                method.nameBank,
                style: TextStyle(
                  color: Color(0xFF2B2B2B),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

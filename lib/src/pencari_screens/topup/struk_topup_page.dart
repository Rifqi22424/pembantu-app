// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/database/shared_preferences.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class StrukTopUpPage extends StatefulWidget {
  final int digitTopUp;
  final String bankImages;
  final String bankNames;
  final int bankIndex;
  StrukTopUpPage(
      {required this.digitTopUp,
      required this.bankImages,
      required this.bankNames,
      required this.bankIndex});

  @override
  State<StrukTopUpPage> createState() => _StrukTopUpPageState();
}

class _StrukTopUpPageState extends State<StrukTopUpPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Container(
            width: deviceTypeTablet() ? 340 : screenWidth,
            child: Column(
              children: [
                Stack(
                  children: [
                    // back(context),
                    // title(),
                    cancel(context),
                  ],
                ),
                TopUpSuccesSign(),
                InformationText(),
                // SizedBox(height: 16),
                // Button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void copyToClipBoard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: "220623001"));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Teks telah disalin ke clipboard'),
    ));
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
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
            SizedBox(height: 4),
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            SizedBox(height: 16),
            Text(
              'Metode Pembayaran',
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                    width: 35,
                    height: 35,
                    child: Image.asset(widget.bankImages)),
                SizedBox(width: 12),
                Text(
                  widget.bankNames,
                  style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            SizedBox(height: 16),
            Text(
              'Nomor Virtual Account',
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '220623001',
                  style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.content_copy),
                  onPressed: () {
                    copyToClipBoard(context);
                  },
                  tooltip: 'Salin ke Clipboard',
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              width: 220,
              child: Text(
                'Selesaikan Pembayaran Sebelum 22 Juni 2023, 13:45:15',
                style: TextStyle(
                  color: Color(0xFF2B2B2B),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.67,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding TopUpSuccesSign() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Container(
          width: 300,
          child: Column(
            children: [
              Image.asset('images/check.png', width: 70, height: 70),
              Text(
                'Berhasil melakukan Top Up Data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF00D65D),
                  fontSize: 22,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
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
      padding: const EdgeInsets.only(right: 24, top: 60),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () async {

            String? role = await getRoleFromSharedPreferences();
            
            if (role == 'majikan') {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            } else if (role == 'pekerja') {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/homepekerja', (route) => false);
            }
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

  Button() {
    return ElevatedButton(
      style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFFFDBDB)),
          minimumSize: WidgetStateProperty.all<Size>(Size(320, 44)),
          foregroundColor: WidgetStateProperty.all<Color>(Color(0xFFFF2222))),
      onPressed: () {},
      child: Text(
        'Batalkan Pembayaran',
        style: TextStyle(
          color: Color(0xFFFF2222),
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

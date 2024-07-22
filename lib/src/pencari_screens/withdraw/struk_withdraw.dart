// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/widgets/get_device_type.dart';

import '../../database/shared_preferences.dart';

class StrukWithDrawPage extends StatefulWidget {
  final int nominal;
  final String bankImages;

  StrukWithDrawPage({
    required this.nominal,
    required this.bankImages,
    super.key,
  });

  @override
  State<StrukWithDrawPage> createState() => _StrukWithDrawPageState();
}

class _StrukWithDrawPageState extends State<StrukWithDrawPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SizedBox(
              width: deviceTypeTablet() ? 340 : screenWidth,
              child: Stack(
                children: [
                  greenBackground(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            title(),
                            cancel(context),
                          ],
                        ),
                        SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.only(right: 24, left: 24),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                checkSign(),
                                TextSign(),
                                SizedBox(height: 14),
                                Text(
                                  'Tunggu Beberapa 1-3 Hari untuk Transfer Ke rekening mu',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF828993),
                                    fontSize: 10,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 14),
                                dateFrame(),
                                Divider(thickness: 2, color: Color(0xFFE8E8E8)),
                                SizedBox(height: 14),
                                penerimaContainer(),
                                SizedBox(height: 14),
                                Divider(thickness: 2, color: Color(0xFFE8E8E8)),
                                SizedBox(height: 14),
                                pengirimContainer(),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        shareStruk(),
                      ],
                    ),
                  ),
                ],
              ),
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

  shareStruk() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16, left: 24, right: 24),
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
        onPressed: () {},
        child: Text(
          'Bagikan Bukti Transaksi',
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

  Container transaksiContainer() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Transaksi',
            style: TextStyle(
              color: Color(0xFF080C11),
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID Transaksi',
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
                    color: Color(0xFF080C11),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  pengirimContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detail Transaksi',
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID Transaksi',
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
                  color: Color(0xFF080C11),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bank',
              style: TextStyle(
                color: Color(0xFF828993),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.asset(
              widget.bankImages,
              width: 32,
              height: 32,
            ),
          ],
        ),
      ],
    );
  }

  penerimaContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Withdraw ke',
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Jane Cooper',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF080C11),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0x19FF2E2E),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Text(
                  'Rp. ${NumberFormat.decimalPattern('vi_VN').format(widget.nominal)}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFFFF2E2E),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container dateFrame() {
    return Container(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Text(
                  '21 Mar 2023',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                VerticalDivider(
                  color: Color(0xFFE8E8E8),
                  thickness: 2,
                ),
                Text(
                  '20:00',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
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
          )
        ],
      ),
    );
  }

  Text TextSign() {
    return Text(
      'Withdraw Berhasil',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF00D65D),
        fontSize: 22,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Image checkSign() {
    return Image.asset(
      'images/check.png',
      width: 80,
      height: 80,
    );
  }

  Container greenBackground() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/profileBG.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Center title() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 60),
          child: Text(
            'Withdraw',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}

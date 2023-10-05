// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class StrukTransferPage extends StatelessWidget {
  const StrukTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
      child: Container(
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
                      back(context),
                      title(),
                    ],
                  ),
                  SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.only(right: 24, left: 24),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          checkSign(),
                          TextSign(),
                          SizedBox(height: 14),
                          dateFrame(),
                          Divider(thickness: 2, color: Color(0xFFE8E8E8)),
                          SizedBox(height: 14),
                          penerimaContainer(),
                          SizedBox(height: 14),
                          Divider(thickness: 2, color: Color(0xFFE8E8E8)),
                          SizedBox(height: 14),
                          pengirimContainer(),
                          SizedBox(height: 14),
                          Divider(thickness: 2, color: Color(0xFFE8E8E8)),
                          SizedBox(height: 14),
                          transaksiContainer(),
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
    ));
  }

  shareStruk() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF38800C)),
          minimumSize: MaterialStateProperty.all<Size>(Size(320, 44)),
        ),
        onPressed: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => ConfirmPinPage()));
        },
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

  Container pengirimContainer() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Pengirim',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Bayar',
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
                  color: Color(0xFFFFEAEA),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Text(
                  'Rp. 2.500.000',
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
        ],
      ),
    );
  }

  Container penerimaContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Penerima',
            style: TextStyle(
              color: Color(0xFF080C11),
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Container(
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
                  'Total Bayar',
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
                    color: Color(0xFFEBF2E7),
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  child: Text(
                    'Rp. 2.500.000',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF38800C),
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
      ),
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
      'Berhasil melakukan Transfer Dana',
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
            'Transfer',
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

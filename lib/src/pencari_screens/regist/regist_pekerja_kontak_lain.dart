// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:prt/src/api/regist_pekerja_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class RegistPekerjaKontakLain extends StatefulWidget {
  const RegistPekerjaKontakLain({super.key});

  @override
  State<RegistPekerjaKontakLain> createState() =>
      _RegistPekerjaKontakLainState();
}

class _RegistPekerjaKontakLainState extends State<RegistPekerjaKontakLain> {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String namalengkap = '';
  String alamatktp = '';
  String notelp = '';
  String alamat = '';

  late String authToken;
  late String id;
  late RegistPekerjaModel pekerjaRegist;

  @override
  void initState() {
    super.initState();
    authToken = '1|F66Hl9KKOXXVDZeF7vHBNh8Xy67ooDlPLe92Gzgpa8caab24';
    id = '1';
    pekerjaRegist = RegistPekerjaModel(authToken: authToken, id: id);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: deviceTypeTablet() ? 340 : screenWidth,
          height: screenHeight,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.06),
              navback(context),
              TopText(),
              checklist(),
              ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            children: [
                              _NamaLengkap(),
                              SizedBox(height: 12),
                              _AlamatKTP(),
                              SizedBox(height: 12),
                              _NoTelp(),
                              SizedBox(height: 12),
                              _Alamat(),
                            ],
                          ),
                          Spacer(),
                          submitButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  navback(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        child: Image.asset('images/NavigateBack.png', width: 25, height: 25),
      ),
    );
  }

  Padding checklist() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset('images/filCheck.png', width: 25, height: 25),
                  Text(
                    'Data Diri',
                    style: TextStyle(
                      color: Color(0xFF828892),
                      fontSize: 8,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                      height: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dash(
                dashColor: Color(0xFF39810D),
                length: 40,
                dashLength: 8,
                dashGap: 2,
                direction: Axis.horizontal,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Image.asset('images/filCheck.png', width: 25, height: 25),
                  Text(
                    'Keterangan',
                    style: TextStyle(
                      color: Color(0xFF828892),
                      fontSize: 8,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dash(
                dashColor: Color(0xFF39810D),
                length: 40,
                dashLength: 8,
                dashGap: 2,
                direction: Axis.horizontal,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Image.asset('images/filCheck.png', width: 25, height: 25),
                  Text(
                    'Kontak Lain',
                    style: TextStyle(
                      color: Color(0xFF828892),
                      fontSize: 8,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dash(
                dashColor: Color(0xFF828892),
                length: 40,
                dashLength: 8,
                dashGap: 2,
                direction: Axis.horizontal,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Image.asset('images/emptyCheck.png', width: 25, height: 25),
                  Text(
                    'Pengalaman',
                    style: TextStyle(
                      color: Color(0xFF828892),
                      fontSize: 8,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                      height: 1.7,
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

  Padding TopText() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No. Telp Lain Yang Bisa Dihubungi',
              style: TextStyle(
                color: Color(0xFF080B11),
                fontSize: 22,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Seseorang yang dekat dengan anda Ayah, Ibu, Anak, Sodara, Tetangga.',
              style: TextStyle(
                color: Color(0xFF828892),
                fontSize: 12,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _NamaLengkap() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        decoration: InputDecoration(
          hintText: 'Nama Lengkap',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
        onSaved: (String? value) {
          namalengkap = value!;
        },
      ),
    );
  }

  Widget _AlamatKTP() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        decoration: InputDecoration(
          hintText: 'Alamat KTP',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
        onSaved: (String? value) {
          alamatktp = value!;
        },
      ),
    );
  }

  Widget _NoTelp() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'No. Telp',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
        onSaved: (String? value) {
          notelp = value!;
        },
      ),
    );
  }

  Widget _Alamat() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        decoration: InputDecoration(
          hintText: 'Alamat Sekarang',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
        onSaved: (String? value) {
          alamat = value!;
        },
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF38800C)),
          minimumSize:
              MaterialStateProperty.all<Size>(Size(double.maxFinite, 44)),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();

            try {
              bool success = await pekerjaRegist.registerFourthPage(
                namalengkap,
                alamatktp,
                notelp,
                alamat,
              );
              if (success) {
                Navigator.pushNamed(context, '/registpekerjapengalaman');
              }
            } catch (e) {
              print('Error $e');
            }
          }
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
    );
  }
}

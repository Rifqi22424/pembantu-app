// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:prt/src/api/regist_pekerja_model.dart';
import 'package:prt/src/mixins/validation_mixin.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class RegistPekerjaKontakLain extends StatefulWidget {
  const RegistPekerjaKontakLain({super.key});

  @override
  State<RegistPekerjaKontakLain> createState() =>
      _RegistPekerjaKontakLainState();
}

class _RegistPekerjaKontakLainState extends State<RegistPekerjaKontakLain>
    with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String namalengkap = '';
  String alamatktp = '';
  String notelp = '';
  String alamat = '';

  late String authToken;
  late String id;
  late RegistPekerjaModel pekerjaRegist;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    pekerjaRegist = RegistPekerjaModel();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: SingleChildScrollView(
          child: Center(
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
                                  _namaLengkap(),
                                  SizedBox(height: 12),
                                  _alamatKTP(),
                                  SizedBox(height: 12),
                                  _noTelp(),
                                  SizedBox(height: 12),
                                  _alamat(),
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

  Widget _namaLengkap() {
    return TextFormField(
      validator: validateName,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      decoration: InputDecoration(
        labelText: 'Nama Lengkap',
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Warna border
              width: 2.0, // Lebar border
            ),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        labelStyle: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
      ),
      onSaved: (String? value) {
        namalengkap = value!;
      },
    );
  }

  Widget _alamatKTP() {
    return TextFormField(
      validator: validateAlamat,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      decoration: InputDecoration(
        labelText: 'Alamat KTP',
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Warna border
              width: 2.0, // Lebar border
            ),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        labelStyle: TextStyle(
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
    );
  }

  Widget _noTelp() {
    return TextFormField(
      validator: validatePhone,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'No. Telp',
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Warna border
              width: 2.0, // Lebar border
            ),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        labelStyle: TextStyle(
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
    );
  }

  Widget _alamat() {
    return TextFormField(
      validator: validateAlamat,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      decoration: InputDecoration(
        labelText: 'Alamat Sekarang',
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Warna border
              width: 2.0, // Lebar border
            ),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        labelStyle: TextStyle(
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
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
          minimumSize:
              WidgetStateProperty.all<Size>(Size(double.maxFinite, 44)),
        ),
        onPressed: () async {
          formKey.currentState!.validate();
          formKey.currentState!.save();
          if (namalengkap == '' ||
              alamatktp == '' ||
              notelp == '' ||
              alamat == '') {
            _showTopSnackbar(context, "Lengkapi data terlebih dahulu", false);
          } else {
            try {
              setState(() {
                isLoading = true;
              });
              bool success = await pekerjaRegist.registerFourthPage(
                namalengkap,
                alamatktp,
                notelp,
                alamat,
              );
              if (success) {
                Navigator.pushNamed(context, '/registpekerjapengalaman');
                _showTopSnackbar(context, "Data telah tersimpan", true);

                setState(() {
                  isLoading = false;
                });
              }
            } catch (e) {
              print('Error $e');
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
}

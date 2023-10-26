// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

import '../../api/fetch_data.dart';
import '../../api/regist_pekerja_model.dart';

class RegistPekerjaKeterangan extends StatefulWidget {
  const RegistPekerjaKeterangan({super.key});

  @override
  State<RegistPekerjaKeterangan> createState() =>
      _RegistPekerjaKeteranganState();
}

class _RegistPekerjaKeteranganState extends State<RegistPekerjaKeterangan> {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String noktp = '';
  String notelp = '';
  String tinggibadan = '';
  String beratbadan = '';
  String? selectedUsia;
  List<String> usiaOptions =
      List.generate(33, (index) => (index + 18).toString());
  String? selectedStatus;

  late String authToken;
  late String id;
  late FetchData fetchData;
  late RegistPekerjaModel pekerjaRegist;

  @override
  void initState() {
    super.initState();
    authToken = '1|wLQRRxEnI5e4U6LMb6dUn49LJovzoUwKy8rUq9lh66972726';
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
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: screenHeight,
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
                                  _NoKTP(),
                                  SizedBox(height: 12),
                                  _NoTelp(),
                                  SizedBox(height: 12),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _TinggiBadan(),
                                        SizedBox(height: 10),
                                        _BeratBadan(),
                                      ]),
                                  SizedBox(height: 12),
                                  _Usia(),
                                  SizedBox(height: 12),
                                  _Status(),
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
              'Selamat Datang 👋',
              style: TextStyle(
                color: Color(0xFF080B11),
                fontSize: 22,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Silahkan isi Data Diri Tentang anda dan penglaman Bekerja',
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

  Widget _NoKTP() {
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
          hintText: 'No. KTP',
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
          noktp = value!;
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

  _TinggiBadan() {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Container(
        width: 160,
        height: 54,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Tinggi Badan',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
                  hintStyle: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 11,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.7),
                onSaved: (String? value) {
                  tinggibadan = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Text(
                'cm',
                style: TextStyle(
                  color: Color(0xFF080C11),
                  fontSize: 11,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                  height: 1.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _BeratBadan() {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Container(
        width: 160,
        height: 54,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Berat Badan',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
                  hintStyle: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 11,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.7),
                onSaved: (String? value) {
                  beratbadan = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Text(
                'Kg',
                style: TextStyle(
                  color: Color(0xFF080C11),
                  fontSize: 11,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                  height: 1.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _Usia() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              alignment: AlignmentDirectional.bottomCenter,
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 12,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              hint: Text(
                'Usia',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 11,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                  height: 1.7,
                ),
              ),
              value: selectedUsia,
              onChanged: (String? newValue) {
                setState(() {
                  selectedUsia = newValue!;
                });
              },
              items: usiaOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              'Tahun',
              style: TextStyle(
                color: Color(0xFF828993),
                fontSize: 11,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _Status() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: DropdownButtonFormField<String>(
        icon: Image.asset('images/option.png'),
        hint: Text(
          'Status',
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          hintStyle: TextStyle(fontSize: 12),
        ),
        value: selectedStatus, // Nilai yang terpilih
        items: <DropdownMenuItem<String>>[
          DropdownMenuItem<String>(
            value: '1', // Unique value for 'Belum menikah'
            child: Text('Belum menikah'),
          ),
          DropdownMenuItem<String>(
            value: '2', // Unique value for 'Sudah menikah'
            child: Text('Sudah menikah'),
          ),
        ],
        onChanged: (String? newValue) {
          setState(() {
            selectedStatus = newValue; // No need to change the value here
          });
        },
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
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
              bool success = await pekerjaRegist.registerThirdPage(
                noktp,
                notelp,
                tinggibadan,
                beratbadan,
                selectedUsia!,
                selectedStatus!,
              );
              if (success) {
                Navigator.pushNamed(context, '/registpekerjakontaklain');
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

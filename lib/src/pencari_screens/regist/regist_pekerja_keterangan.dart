// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:prt/src/mixins/validation_mixin.dart';
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

class _RegistPekerjaKeteranganState extends State<RegistPekerjaKeterangan>
    with ValidationMixin {
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

  bool ktpErr = false;
  bool noTelpErr = false;

  late String authToken;
  late String id;
  late FetchData fetchData;
  late RegistPekerjaModel pekerjaRegist;
  bool isLoading = false;

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
                      margin: EdgeInsets.only(top: 10),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            ListView(
                              shrinkWrap: true,
                              children: [
                                _noKTP(),
                                SizedBox(height: 12),
                                // (ktpErr) ? ktpError() : SizedBox(height: 12),
                                _noTelp(),
                                SizedBox(height: 12),
                                // (noTelpErr)
                                //     ? noTelpError()
                                //     : SizedBox(height: 12),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _tinggiBadan(),
                                      SizedBox(width: 12),
                                      _beratBadan(),
                                    ]),
                                SizedBox(height: 12),
                                _usia(),
                                SizedBox(height: 12),
                                _status(),
                              ],
                            ),
                            Spacer(),
                            _submitButton(),
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
            Column(
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
              'Silahkan isi Data Diri Tentang anda dan pengalaman Bekerja',
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

  Widget _noKTP() {
    return TextFormField(
      validator: validateNoKtp,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'No. KTP',
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
        noktp = value!;
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
        hintText: 'ex: 081122334455',
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
        hintStyle: TextStyle(
          color: Color.fromARGB(149, 130, 137, 147),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
      ),
      onSaved: (String? value) {
        notelp = value!;
      },
    );
  }

  _tinggiBadan() {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Stack(
        children: [
          TextFormField(
            validator: validateNonNull,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: 'Tinggi Badan',
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Warna border
                    width: 2.0, // Lebar border
                  ),
                  borderRadius: BorderRadius.circular(32)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              labelStyle: TextStyle(
                color: Color(0xFF828993),
                fontSize: 11,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.7,
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
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 14, top: 10),
              child: Text(
                'cm',
                style: TextStyle(
                  color: Color(0xFF080C11),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                  height: 1.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _beratBadan() {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Stack(
        children: [
          TextFormField(
            validator: validateNonNull,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: 'Berat Badan',
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Warna border
                    width: 2.0, // Lebar border
                  ),
                  borderRadius: BorderRadius.circular(32)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              labelStyle: TextStyle(
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
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 14, top: 10),
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
          ),
        ],
      ),
    );
  }

  Widget _usia() {
    return Stack(
      children: [
        DropdownButtonFormField<String>(
          validator: validateNonNull,
          icon: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Image.asset('images/option.png'),
          ),
          alignment: AlignmentDirectional.bottomCenter,
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
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
            labelText: 'Usia',
            labelStyle: TextStyle(
              color: Color(0xFF828993),
              fontSize: 12,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
              height: 1.71,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue, // Warna border
                  width: 2.0, // Lebar border
                ),
                borderRadius: BorderRadius.circular(32)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 12, top: 14),
            child: Text(
              'Tahun',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 11,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _status() {
    return DropdownButtonFormField<String>(
      validator: validateNonNull,
      icon: Image.asset('images/option.png'),
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      decoration: InputDecoration(
        labelText: 'Status',
        labelStyle: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Warna border
              width: 2.0, // Lebar border
            ),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        hintStyle: TextStyle(fontSize: 12),
      ),
      value: selectedStatus, // Nilai yang terpilih
      items: <DropdownMenuItem<String>>[
        DropdownMenuItem<String>(
          value: '1',
          child: Text('Belum menikah'),
        ),
        DropdownMenuItem<String>(
          value: '2',
          child: Text('Sudah menikah'),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() {
          selectedStatus = newValue;
        });
      },
    );
  }

  void validationKtp() {
    final ktp = noktp;
    final ktpError = validateNoKtp(ktp);

    setState(() {
      ktpErr = ktpError != null;
    });
  }

  void validationNoTelp() {
    final noTelp = notelp;
    final telpErr = validatePhone(noTelp);

    setState(() {
      noTelpErr = telpErr != null;
    });
  }

  Widget _submitButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
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
          validationKtp();
          validationNoTelp();
          if (noktp == '' ||
              tinggibadan == '' ||
              beratbadan == '' ||
              selectedUsia == null ||
              selectedStatus == null) {
            _showTopSnackbar(context, "Lengkapi data terlebih dahulu", false);
          } else {
            try {
              setState(() {
                isLoading = true;
              });
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

  ktpError() {
    final ktp = noktp;
    final ktpErr = validateNoKtp(ktp);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            '*$ktpErr!',
            style: TextStyle(
              color: Color(0xFFFF2222),
              fontSize: 10,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  noTelpError() {
    final noTelp = notelp;
    final telpErr = validatePhone(noTelp);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            '*$telpErr!',
            style: TextStyle(
              color: Color(0xFFFF2222),
              fontSize: 10,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
        ),
      ],
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

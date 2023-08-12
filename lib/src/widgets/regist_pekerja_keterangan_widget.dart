import 'package:flutter/material.dart';
import 'package:prt/src/screens/regist_pekerja_kontak_lain.dart';
import '../mixins/validation_mixin.dart';

class RegistPekerjaDataDiriWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<RegistPekerjaDataDiriWidget>
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _NoKTP(),
            SizedBox(height: 12),
            _NoTelp(),
            SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _TinggiBadan(),
              SizedBox(height: 2),
              _BeratBadan(),
            ]),
            SizedBox(height: 12),
            _Usia(),
            SizedBox(height: 12),
            _Kecamatan(),
            SizedBox(height: 20),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget _NoKTP() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'No. KTP',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12.5,
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
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'No. Telp',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12.5,
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

  Widget _TinggiBadan() {
    return Container(
      width: 150,
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
                  color: Color(0xFF828993),
                  fontSize: 12.5,
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

  Widget _BeratBadan() {
    return Container(
      width: 150,
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
                  color: Color(0xFF828993),
                  fontSize: 12.5,
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

  Widget _Usia() {
    return Container(
      width: 320,
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
                color: Color(0xFF828993),
                fontSize: 12.5,
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

  Widget _Kecamatan() {
    return Container(
      width: 320,
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
            fontSize: 12.5,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12.5,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          hintStyle: TextStyle(fontSize: 12.5),
        ),
        value: selectedStatus, // Nilai yang terpilih
        items: <String>['Belum menikah', 'Sudah menikah'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedStatus = newValue!; // Ubah nilai yang terpilih
          });
        },
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: MaterialStateProperty.all<Size>(Size(320, 50)),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          print(
              'post $noktp, $notelp, $tinggibadan, $beratbadan, $selectedUsia, ');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegistPekerjaKontakLain()));
        }
      },
      child: Text('Selanjutnya'),
    );
  }
}

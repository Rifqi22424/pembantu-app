import 'package:flutter/material.dart';
import 'package:prt/src/screens/regist_pekerja_keterangan.dart';
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

  String namalengkap = '';
  String nomorhp = '';
  String password = '';
  String? selectedProvinsi;
  String? selectedKabupaten;
  String? selectedKecamatan;
  String alamatKTP = '';
  String alamat = '';
  DateTime? selectedDate;
  String? selectedJenisKelamin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _NamaLengkap(),
            SizedBox(height: 12),
            _Provinsi(),
            SizedBox(height: 12),
            _Kabupaten(),
            SizedBox(height: 12),
            _Kecamatan(),
            SizedBox(height: 12),
            _AlamatKTP(),
            SizedBox(height: 12),
            _Alamat(),
            SizedBox(height: 12),
            _DatePickerButton(),
            SizedBox(height: 12),
            _JenisKelamin(),
            SizedBox(height: 20),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget _NamaLengkap() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Nama Lengkap',
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
          namalengkap = value!;
        },
      ),
    );
  }

  Widget _Provinsi() {
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
          'Provinsi',
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
        value: selectedProvinsi, // Nilai yang terpilih
        items:
            <String>['Papua', 'Jawa Barat', 'Jawa Timur'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedProvinsi = newValue!; // Ubah nilai yang terpilih
          });
        },
      ),
    );
  }

  Widget _Kabupaten() {
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
          'Kabupaten',
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
        value: selectedKabupaten, // Nilai yang terpilih
        items: <String>['Sukabumi', 'Bandung', 'Cimahi'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedKabupaten = newValue!; // Ubah nilai yang terpilih
          });
        },
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
          'Kecamatan',
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
        value: selectedKecamatan, // Nilai yang terpilih
        items: <String>['Cibereum hilir', 'Lembur situ'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedKecamatan = newValue!; // Ubah nilai yang terpilih
          });
        },
      ),
    );
  }

  Widget _AlamatKTP() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Alamat KTP',
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
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12.5,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        onSaved: (String? value) {
          alamatKTP = value!;
        },
      ),
    );
  }

  Widget _Alamat() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Alamat Sekarang',
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
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12.5,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        onSaved: (String? value) {
          alamat = value!;
        },
      ),
    );
  }

  Widget _DatePickerButton() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextButton(
        onPressed: () {
          _selectDate(context);
        },
        child: Text(
          selectedDate == null
              ? 'Pilih Tanggal Lahir'
              : 'Tanggal lahir: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12.5,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _JenisKelamin() {
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
          'Kecamatan',
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
        value: selectedJenisKelamin, // Nilai yang terpilih
        items: <String>['Laki-laki', 'Perempuan'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedJenisKelamin = newValue!; // Ubah nilai yang terpilih
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
          print('post $namalengkap, $nomorhp and $password');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegistPekerjaKeterangan()));
        }
      },
      child: Text('Selanjutnya'),
    );
  }
}

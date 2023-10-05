// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import '../../api/fetch_data.dart';
import '../../widgets/scroll_behavior.dart';
import '../../api/regist_pekerja_model.dart';

class RegistPekerjaDataDiri extends StatefulWidget {
  const RegistPekerjaDataDiri({super.key});

  @override
  State<RegistPekerjaDataDiri> createState() => _RegistPekerjaDataDiriState();
}

class _RegistPekerjaDataDiriState extends State<RegistPekerjaDataDiri> {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String namalengkap = '';
  String nomorhp = '';
  String password = '';
  String? selectedProvinsi;
  String? selectedKota;
  String? selectedKecamatan;
  String alamatKTP = '';
  String? selectedAgama;
  String alamat = '';
  DateTime? selectedDate;
  String? selectedJenisKelamin;

  late String authToken;
  late String id;
  late FetchData fetchData;
  late RegistPekerjaModel pekerjaRegist;

  Map<String, dynamic> provinsiData = {};
  Map<String, dynamic> kotaData = {};
  Map<String, dynamic> kecamatanData = {};

  @override
  void initState() {
    super.initState();
    authToken = '1|F66Hl9KKOXXVDZeF7vHBNh8Xy67ooDlPLe92Gzgpa8caab24';
    id = '1';
    fetchData = FetchData(authToken, id);
    pekerjaRegist = RegistPekerjaModel(authToken: authToken, id: id);
    fetchProvinsiData();
    fetchKotaData(selectedProvinsi);
    fetchKecamatanData(selectedKota);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  TopText(),
                  checklist(),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          _NamaLengkap(),
                          SizedBox(height: 12),
                          _Provinsi(),
                          SizedBox(height: 12),
                          _Kota(),
                          SizedBox(height: 12),
                          _Kecamatan(),
                          SizedBox(height: 12),
                          _AlamatKTP(),
                          SizedBox(height: 12),
                          _agama(),
                          SizedBox(height: 12),
                          _Alamat(),
                          SizedBox(height: 12),
                          _DatePickerButton(),
                          SizedBox(height: 12),
                          _JenisKelamin(),
                          SizedBox(height: 20),
                          submitButton(),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  checklist() {
    return Center(
      child: Padding(
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
      ),
    );
  }

  TopText() {
    return Container(
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
          fontSize: 14,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        decoration: InputDecoration(
          hintText: 'Nama Lengkap',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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

  Widget _Provinsi() {
    return Container(
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
        value: selectedProvinsi, // Nilai yang terpilih
        items: provinsiData.entries.map((entry) {
          String key = entry.key;
          String value = entry.value.toString();
          return DropdownMenuItem<String>(
            value: key, // Menggunakan nomor provinsi sebagai nilai
            child: Text(value), // Menampilkan nama provinsi
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            // Pastikan newValue tidak null
            setState(() {
              selectedProvinsi = newValue;
              fetchKotaData(selectedProvinsi);
              selectedKota = null;
              selectedKecamatan = null;
            });
          }
        },
      ),
    );
  }

  Widget _Kota() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: DropdownButtonFormField<String>(
        icon: Image.asset('images/option.png'),
        hint: Text(
          'Kabupaten/ Kota',
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
        value: selectedKota, // Nilai yang terpilih
        items: kotaData.entries.map((entry) {
          String key = entry.key;
          String value = entry.value.toString();
          return DropdownMenuItem<String>(
            value: key, // Menggunakan nomor provinsi sebagai nilai
            child: Text(value), // Menampilkan nama provinsi
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            // Pastikan newValue tidak null
            setState(() {
              selectedKota = newValue;
              fetchKecamatanData(selectedKota);
              selectedKecamatan = null;
            });
          }
        },
      ),
    );
  }

  Widget _Kecamatan() {
    return Container(
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
        value: selectedKecamatan, // Nilai yang terpilih
        items: kecamatanData.entries.map((entry) {
          String key = entry.key;
          String value = entry.value.toString();
          return DropdownMenuItem<String>(
            value: key, // Menggunakan nomor provinsi sebagai nilai
            child: Text(value), // Menampilkan nama provinsi
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              selectedKecamatan = newValue;
            });
          }
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
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
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

  Widget _agama() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: DropdownButtonFormField<String>(
        icon: Image.asset('images/option.png'),
        hint: Text(
          'Agama',
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
        value: selectedAgama, // Nilai yang terpilih
        items:
            <String>['Islam', 'Kristen', 'Hindu', 'Budha'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedAgama = newValue!; // Ubah nilai yang terpilih
          });
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
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
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
      width: double.maxFinite,
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
            color: Color(0xFF080C11),
            fontSize: 12,
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
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: DropdownButtonFormField<String>(
        icon: Image.asset('images/option.png'),
        hint: Text(
          'Jenis Kelamin',
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
        minimumSize:
            MaterialStateProperty.all<Size>(Size(double.maxFinite, 44)),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          try {
            bool success = await pekerjaRegist.registerSecondPage(
              namalengkap,
              alamatKTP,
              selectedKecamatan!,
              selectedAgama!,
              alamat,
              selectedDate.toString(),
              selectedJenisKelamin!,
            );

            if (success) {
              Navigator.pushNamed(context, '/registpekerjaketerangan');
            }
          } catch (e) {
            print('Error: $e');
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
    );
  }

  Future<void> fetchProvinsiData() async {
    try {
      final data = await fetchData.fetchProvinsiData();
      setState(() {
        provinsiData = data;
      });
    } catch (e) {
      print('Error $e');
    }
  }

  Future<void> fetchKotaData(String? selectedProvinsi) async {
    try {
      final data = await fetchData.fetchKotaData(selectedProvinsi!);
      setState(() {
        kotaData = data;
      });
    } catch (e) {
      print('Error $e');
    }
  }

  Future<void> fetchKecamatanData(String? selectedKota) async {
    try {
      final data = await fetchData.fetchKecamatanData(selectedKota!);
      setState(() {
        kecamatanData = data;
      });
    } catch (e) {
      print('Error $e');
    }
  }
}

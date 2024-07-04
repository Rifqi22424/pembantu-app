// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:prt/src/mixins/validation_mixin.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import '../../api/fetch_data.dart';
import '../../widgets/scroll_behavior.dart';
import '../../api/regist_pekerja_model.dart';
import '../../widgets/show_top_snackbar.dart';

class RegistPekerjaDataDiri extends StatefulWidget {
  const RegistPekerjaDataDiri({super.key});

  @override
  State<RegistPekerjaDataDiri> createState() => _RegistPekerjaDataDiriState();
}

class _RegistPekerjaDataDiriState extends State<RegistPekerjaDataDiri>
    with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String namalengkap = '';
  String nomorhp = '';
  String? selectedProvinsi;
  String? selectedKota;
  String? selectedKecamatan;
  String alamatKTP = '';
  String? selectedAgama;
  String alamat = '';
  DateTime? selectedDate;
  String? selectedJenisKelamin;

  TextEditingController _dateController = TextEditingController();

  late String authToken;
  late String id;
  late FetchData fetchData;
  late RegistPekerjaModel pekerjaRegist;

  Map<String, dynamic> provinsiData = {};
  Map<String, dynamic> kotaData = {};
  Map<String, dynamic> kecamatanData = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    authToken = '1|wLQRRxEnI5e4U6LMb6dUn49LJovzoUwKy8rUq9lh66972726';
    id = '1';
    fetchData = FetchData(id);
    pekerjaRegist = RegistPekerjaModel();
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
                  SizedBox(height: screenHeight * 0.08),
                  TopText(),
                  checklist(),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          _namaLengkap(),
                          SizedBox(height: 12),
                          _provinsi(),
                          SizedBox(height: 12),
                          _kota(),
                          SizedBox(height: 12),
                          _kecamatan(),
                          SizedBox(height: 12),
                          _alamatKTP(),
                          SizedBox(height: 12),
                          // (alamatKtpErr)
                          //     ? alamatKtpError()
                          //     : SizedBox(height: 12),
                          _agama(),
                          SizedBox(height: 12),
                          _alamat(),
                          SizedBox(height: 12),
                          // (alamatErr) ? alamatError() : SizedBox(height: 12),
                          _datePickerButton(),
                          SizedBox(height: 12),
                          _jenisKelamin(),
                          SizedBox(height: 20),
                          _submitButton(),
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

  Widget _provinsi() {
    return DropdownButtonFormField<String>(
      validator: validateNonNull,
      icon: Image.asset('images/option.png'),
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 10,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      decoration: InputDecoration(
        labelText: 'Provinsi',
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
    );
  }

  Widget _kota() {
    return DropdownButtonFormField<String>(
      validator: validateNonNull,
      icon: Image.asset('images/option.png'),
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 10,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      decoration: InputDecoration(
        labelText: 'Kabupaten/ Kota',
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
    );
  }

  Widget _kecamatan() {
    return DropdownButtonFormField<String>(
      validator: validateNonNull,

      icon: Image.asset('images/option.png'),
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 10,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      decoration: InputDecoration(
        labelText: 'Kecamatan',
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
    );
  }

  alamatError() {
    final alamatValidate = alamat;
    final alamatErr = validateAlamat(alamatValidate);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            '*$alamatErr!',
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

  alamatKtpError() {
    final alamatKtpValidate = alamatKTP;
    final alamatKtpErr = validateAlamat(alamatKtpValidate);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            '*$alamatKtpErr!',
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

  Widget _alamatKTP() {
    return TextFormField(
      validator: validateAlamat,
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
          height: 1.71,
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
    );
  }

  Widget _agama() {
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
        labelText: 'Agama',
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
      value: selectedAgama, // Nilai yang terpilih
      items: <String>['Islam', 'Kristen', 'Hindu', 'Budha'].map((String value) {
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
    );
  }

  Widget _alamat() {
    return TextFormField(
      validator: validateAlamat,
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
          height: 1.71,
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
    );
  }

  // Widget _datePickerButton() {
  //   return Container(
  //     width: double.maxFinite,
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey),
  //       borderRadius: BorderRadius.all(Radius.circular(32)),
  //     ),
  //     child: TextButton(
  //       onPressed: () {
  //         _selectDate(context);
  //       },
  //       child: Text(
  //         selectedDate == null
  //             ? 'Pilih Tanggal Lahir'
  //             : 'Tanggal lahir: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
  //         style: TextStyle(
  //           color: Color(0xFF080C11),
  //           fontSize: 12,
  //           fontFamily: 'Asap',
  //           fontWeight: FontWeight.w400,
  //           height: 1.4,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _datePickerButton() {
    return TextFormField(
        controller: _dateController,
        decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.center,
          labelText: 'Pilih Tanggal Lahir',
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(32)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          labelStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.71,
          ),
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        readOnly: true,
        onTap: () {
          _selectDate(context);
        },
        validator: validateNonNull);
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
        _dateController.text =
            '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
      });
    }
  }

  Widget _jenisKelamin() {
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
        labelText: 'Jenis Kelamin',
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
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 44)),
      ),
      onPressed: () async {
        formKey.currentState!.validate();
        formKey.currentState!.save();
        // validationAlamat();
        // validationAlamatKtp();
        if (namalengkap == '' ||
            selectedProvinsi == null ||
            selectedKota == null ||
            selectedKecamatan == null ||
            selectedAgama == null ||
            selectedDate == null ||
            selectedJenisKelamin == null ||
            alamatKTP == '' ||
            alamat == '') {
          _showTopSnackbar(context, "Lengkapi data terlebih dahulu", false);
        } else {
          try {
            setState(() {
              isLoading = true;
            });
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
              _showTopSnackbar(context, "Data telah tersimpan", true);
              setState(() {
                isLoading = false;
              });
            }
          } catch (e) {
            print('Error: $e');
            showTopSnackbar(context, 'Sedang dalam maintanance');
            setState(() {
              isLoading = false;
            });
          }
        }
      },
      child: isLoading? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ): Text(
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

  // void validationAlamat() {
  //   final alamatValidate = alamat;
  //   final alamatError = validateAlamat(alamatValidate);

  //   setState(() {
  //     alamatErr = alamatError != null;
  //   });
  // }

  // void validationAlamatKtp() {
  //   final alamatKtpValidate = alamatKTP;
  //   final alamatKtpError = validateAlamat(alamatKtpValidate);

  //   setState(() {
  //     alamatKtpErr = alamatKtpError != null;
  //   });
  // }

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

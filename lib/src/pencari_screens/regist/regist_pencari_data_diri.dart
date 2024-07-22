// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

import '../../api/regist_pekerja_model.dart';
import '../../mixins/validation_mixin.dart';
import '../login_page.dart';

class RegistPencariDataDiri extends StatefulWidget {
  const RegistPencariDataDiri({super.key});

  @override
  State<RegistPencariDataDiri> createState() => _RegistPencariDataDiriState();
}

class _RegistPencariDataDiriState extends State<RegistPencariDataDiri>
    with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  bool ktpErr = false;
  bool alamatErr = false;
  bool noTelpErr = false;

  // String noktp = '';
  // String namaLengkap = '';
  // String alamat = '';
  // String notelp = '';
  // String? selectedUsia;
  // List<String> usiaOptions =
  //     List.generate(33, (index) => (index + 18).toString());
  // String? selectedStatus;

  String noktp = '1234567890123456';
  String namaLengkap = 'rifqi m';
  String alamat = 'sukabumi';
  String notelp = '0857210404298';
  String selectedUsia = "20";
  List<String> usiaOptions =
      List.generate(33, (index) => (index + 18).toString());
  String selectedStatus = "1";
  File? selectedKTPImg;
  File? selectedHalfImg;

  bool selectedKTPImgErr = false;
  bool selectedHalfImgErr = false;
  bool isLoading = false;

  late RegistPekerjaModel pencariRegist;

  void initState() {
    super.initState();
    pencariRegist = RegistPekerjaModel();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: SingleChildScrollView(
          child: Container(
            width: deviceTypeTablet() ? 340 : screenWidth,
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.06),
                navback(context),
                SizedBox(height: 16),
                TopText(),
                SizedBox(height: 60),
                Form(
                  key: formKey,
                  child: SizedBox(
                    child: Column(
                      children: [
                        _noKTP(),
                        SizedBox(height: 16),
                        // (ktpErr) ? ktpError() : SizedBox(height: 16),
                        _namaLengkap(),
                        SizedBox(height: 16),
                        _alamat(),
                        SizedBox(height: 16),
                        // (alamatErr) ? alamatError() : SizedBox(height: 16),
                        _noTelp(),
                        SizedBox(height: 16),
                        // (noTelpErr) ? noTelpError() : SizedBox(height: 16),
                        _usia(),
                        SizedBox(height: 16),
                        _status(),
                        SizedBox(height: 16),
                        _uploadKTP(),
                        SizedBox(height: 16),
                        _uploadHalfImg(),
                        SizedBox(height: 30),
                        submitButton(),
                      ],
                    ),
                  ),
                ),
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

  TopText() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
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

  Widget _noKTP() {
    return TextFormField(
      initialValue: noktp,
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

  ktpError() {
    final ktp = noktp;
    final ktpErr = validateNoKtp(ktp);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
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

  alamatError() {
    final alamatErr = validateAlamat(alamat);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
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

  noTelpError() {
    final noTelp = notelp;
    final telpErr = validatePhone(noTelp);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
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

  Widget _namaLengkap() {
    return TextFormField(
      validator: validateName,
      initialValue: namaLengkap,
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
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      onSaved: (String? value) {
        namaLengkap = value!;
      },
    );
  }

  Widget _alamat() {
    return TextFormField(
      validator: validateAlamat,
      initialValue: alamat,
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

  Widget _noTelp() {
    return TextFormField(
      validator: validatePhone,
      initialValue: notelp,
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
          selectedStatus = newValue!;
        });
      },
    );
  }

  Widget _uploadKTP() {
    return InkWell(
      onTap: _pickKTPImg,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: (selectedKTPImgErr)
              ? Color.fromARGB(255, 255, 222, 222)
              : Color(0xFFF5F5F5),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Center(
          child: selectedKTPImg == null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'Upload KTP',
                          style: TextStyle(
                            color: Color(0xFF828993),
                            fontSize: 10.5,
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.redAccent[700],
                            fontSize: 14,
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ])),
                      SizedBox(height: 10),
                      Icon(
                        Icons.add_a_photo,
                        size: 38,
                        color: Color(0xFF828993),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kartu Tanda Penduduk',
                        style: TextStyle(
                          color: Color(0xFF828993),
                          fontSize: 10.5,
                          fontFamily: 'Asap',
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 8),
                      Image.file(
                        selectedKTPImg!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _uploadHalfImg() {
    return InkWell(
      onTap: _pickHalfImg,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: (selectedHalfImgErr)
              ? Color.fromARGB(255, 255, 222, 222)
              : Color(0xFFF5F5F5),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Center(
            child: selectedHalfImg == null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'Upload Foto Setengah Badan',
                            style: TextStyle(
                              color: Color(0xFF828993),
                              fontSize: 10.5,
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.redAccent[700],
                              fontSize: 14,
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ])),
                        SizedBox(height: 10),
                        Icon(
                          Icons.add_a_photo,
                          size: 38,
                          color: Color(0xFF828993),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Foto Setengah Badan',
                          style: TextStyle(
                            color: Color(0xFF828993),
                            fontSize: 10.5,
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image.file(
                          selectedHalfImg!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }

  void _pickKTPImg() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedKTPImg = File(pickedImage.path);
      });
    }
  }

  void _pickHalfImg() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedHalfImg = File(pickedImage.path);
      });
    }
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
              WidgetStateProperty.all<Size>(Size(double.maxFinite, 54)),
        ),
        onPressed: () async {
          formKey.currentState!.validate();
          formKey.currentState!.save();
          validationKtp();
          validationNoTelp();
          validationAlamat();
          if (!ktpErr && !noTelpErr && !alamatErr) {
            try {
              setState(() {
                isLoading = true;
              });
              File compressedKTPImg = await compressImage(selectedKTPImg!);
              File compressedHalfImg = await compressImage(selectedHalfImg!);

              bool photoSuccess = await pencariRegist.registersPencariPhoto(
                  compressedKTPImg, compressedHalfImg);

              bool success = await pencariRegist.registerPencariText(
                namaLengkap,
                noktp,
                alamat,
                notelp,
                selectedUsia!,
                selectedStatus!
              );
              // print(success);
              // print(photoSuccess);
              if (success && photoSuccess) {
                // print('post $noktp, $notelp, $selectedUsia');
                // Navigator.pushNamed(context, '/login');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
                _showTopSnackbar(context, "Data berhasil tersimpan", true);
                setState(() {
                  isLoading = false;
                });
              }
            } catch (e) {
              // print('$e');
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

  void validationAlamat() {
    final alamatError = validateAlamat(alamat);

    setState(() {
      alamatErr = alamatError != null;
    });
  }

  Future<File> compressImage(File file) async {
    final int fileSize = await file.length();

    // Determine the compression quality based on the file size
    int quality;
    if (fileSize > 1048576 && fileSize < 3048576) {
      quality = 50;
    } else if (fileSize > 4048576 && fileSize < 5048576) {
      quality = 50;
    } else if (fileSize > 5048576) {
      quality = 50;
    } else {
      return file; // Return original file if no compression needed
    }

    // Compress the image with the determined quality
    final tempDir = await getTemporaryDirectory();
    final targetPath =
        path.join(tempDir.path, '${path.basename(file.path)}_compressed.jpg');

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
      minWidth: 1080,
      minHeight: 1080,
    );

    // Return the compressed file or the original file if compression failed
    return result != null ? File(result.path) : file;
  }
}

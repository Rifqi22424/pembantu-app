import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../mixins/validation_mixin.dart';
import 'package:flutter/services.dart';

class RegistPekerjaPengalamanWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistScreenState();
  }
}

class RegistScreenState extends State<RegistPekerjaPengalamanWidget>
    with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  TextEditingController _controller = TextEditingController();
  List<String> tags = [];
  String? selectedProfesi;
  List<String> selectedSkillList = [];
  String deskripsi = '';
  String pengalaman = '';
  String password = '';
  String? selectedPendidikan;
  String gaji = '';
  File? selectedKTPImg;
  File? selectedSKBImg;
  File? selectedHalfImg;
  File? selectedFullImg;

  void addTag(String tag) {
    setState(() {
      tags.add(tag);
      _controller.clear();
    });
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

  void _pickSKBImg() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedSKBImg = File(pickedImage.path);
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

  void _pickFullImg() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedFullImg = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _Profesi(),
            SizedBox(height: 12),
            _Skill(),
            SizedBox(height: 6),
            _InfoSkillText(),
            SizedBox(height: 6),
            _Deskripsi(),
            SizedBox(height: 12),
            _Pengalaman(),
            SizedBox(height: 12),
            _Pendidikan(),
            SizedBox(height: 12),
            _Gaji(),
            SizedBox(height: 12),
            _UploadKTP(),
            SizedBox(height: 12),
            _UploadSKB(),
            SizedBox(height: 12),
            _UploadHalfImg(),
            SizedBox(height: 12),
            _UploadFullImg(),
            SizedBox(height: 20),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget _Profesi() {
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
          'Profesi',
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
        value: selectedProfesi, // Nilai yang terpilih
        items: <String>['ART', 'Baby Sister', 'Supir', 'PRT', 'Satpam']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedProfesi = newValue!; // Ubah nilai yang terpilih
          });
        },
      ),
    );
  }

  Widget _Skill() {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Skill',
              style: TextStyle(
                color: Color(0xFF828993),
                fontSize: 12.5,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Wrap(
              spacing: 4,
              children: selectedSkillList.map((kabupaten) {
                return Chip(
                  label: Text(kabupaten),
                  labelStyle: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 10.5,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                  onDeleted: () {
                    setState(() {
                      selectedSkillList.remove(kabupaten);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: DropdownButtonFormField<String>(
              icon: Image.asset('images/option.png'),
              isDense: true,
              hint: Text(
                'Tambahkan Skill',
                style: TextStyle(fontSize: 12.5),
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
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              ),
              value: null,
              items: <String>[
                'Mencuci piring',
                'Membasuh baju',
                'Mengemudi mobil'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedSkillList.add(newValue);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _InfoSkillText() {
    return Padding(
      padding: const EdgeInsets.only(left: 130.0),
      child: Text(
        '(Bisa memilih lebih dari 1)',
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 10.5,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _Deskripsi() {
    return Container(
      width: 320,
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Deskripsi',
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
          deskripsi = value!;
        },
      ),
    );
  }

  Widget _Pengalaman() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Pengalaman Bekerja',
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
          pengalaman = value!;
        },
      ),
    );
  }

  Widget _Pendidikan() {
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
          'Pendidikan Terakhir',
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
        value: selectedPendidikan, // Nilai yang terpilih
        items: <String>['SMP/ Sederajat', 'SMA/ Sederajat', 'S1/ Sederajat']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedPendidikan = newValue!; // Ubah nilai yang terpilih
          });
        },
      ),
    );
  }

  Widget _Gaji() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Rp.',
              style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 12.5,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                  height: 1.7),
            ),
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [ThousandsFormatter()],
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Kisaran Gaji',
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
                gaji = value!;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _UploadKTP() {
    return Container(
      width: 320,
      height: 180,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: GestureDetector(
        onTap: _pickKTPImg,
        child: Center(
            child: selectedKTPImg == null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Upload KTP',
                          style: TextStyle(
                            color: Color(0xFF828993),
                            fontSize: 10.5,
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
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
                  )),
      ),
    );
  }

  Widget _UploadSKB() {
    return Container(
      width: 320,
      height: 180,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: GestureDetector(
        onTap: _pickSKBImg,
        child: Center(
            child: selectedSKBImg == null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Upload Surat Kelakuan Baik',
                          style: TextStyle(
                            color: Color(0xFF828993),
                            fontSize: 10.5,
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
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
                          'Surat Kelakuan Baik',
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
                          selectedSKBImg!,
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

  Widget _UploadHalfImg() {
    return Container(
      width: 320,
      height: 180,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: GestureDetector(
        onTap: _pickHalfImg,
        child: Center(
            child: selectedHalfImg == null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Upload Foto Setengah Badan',
                          style: TextStyle(
                            color: Color(0xFF828993),
                            fontSize: 10.5,
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
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

  Widget _UploadFullImg() {
    return Container(
      width: 320,
      height: 170,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: GestureDetector(
        onTap: _pickFullImg,
        child: Center(
            child: selectedFullImg == null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Upload Foto Satu Badan',
                          style: TextStyle(
                            color: Color(0xFF828993),
                            fontSize: 10.5,
                            fontFamily: 'Asap',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
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
                          'Foto Satu Badan',
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
                          selectedFullImg!,
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
          print('post ');
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => overlaySuccessVerif()));
        }
      },
      child: Text('Selanjutnya'),
    );
  }

  overlaySuccessVerif() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 220),
      child: Container(
        width: 300,
        height: 300,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Image.asset('images/exclamation.png', width: 70, height: 70),
            Text(
              'Pendaftaran Anda Berhasil',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF7D003),
                fontSize: 24,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Masuk ke akun anda sekarang',
              style: TextStyle(
                color: Color(0xFF828892),
                fontSize: 12.5,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final numericOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final formattedText = _formatText(numericOnly);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatText(String text) {
    final parts = <String>[];

    for (var i = 0; i < text.length; i += 3) {
      final endIndex = i + 3;
      parts.add(
          text.substring(i, endIndex > text.length ? text.length : endIndex));
    }

    return parts.join('.');
  }
}

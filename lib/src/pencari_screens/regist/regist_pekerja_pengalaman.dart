// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prt/src/api/fetch_data.dart';
import 'package:prt/src/api/regist_pekerja_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class RegistPekerjaPengalaman extends StatefulWidget {
  const RegistPekerjaPengalaman({super.key});

  @override
  State<RegistPekerjaPengalaman> createState() =>
      _RegistPekerjaPengalamanState();
}

class _RegistPekerjaPengalamanState extends State<RegistPekerjaPengalaman> {
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
  File? selectedSertifImg;

  late String authToken;
  late String id;
  late FetchData fetchData;
  late RegistPekerjaModel pekerjaRegist;

  List<dynamic> skillsData = [];
  List<dynamic> categoriesData = [];

  @override
  void initState() {
    super.initState();
    authToken = '1|wLQRRxEnI5e4U6LMb6dUn49LJovzoUwKy8rUq9lh66972726';
    id = '1';
    pekerjaRegist = RegistPekerjaModel();
    fetchData = FetchData(authToken, id);
    fetchSkillData();
    fecthCategoriesData();
  }

  Future<void> fetchSkillData() async {
    try {
      final data = await fetchData.fetchSkillsData();
      setState(() {
        skillsData = data;
      });
    } catch (e) {
      print('Error $e');
    }
  }

  Future<void> fecthCategoriesData() async {
    try {
      final data = await fetchData.fetchCategoriesData();
      setState(() {
        categoriesData = data;
      });
    } catch (e) {
      print('Error $e');
    }
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
                  SizedBox(height: screenHeight * 0.06),
                  navback(context),
                  topText(),
                  checklist(),
                  Container(
                    margin: EdgeInsets.only(top: 30),
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
                          SizedBox(height: 12),
                          _UploadSertifImg(),
                          SizedBox(height: 20),
                          submitButton(),
                          SizedBox(height: screenHeight * 0.02),
                        ],
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

  Padding topText() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Silahkan Isi Pengalaman-mu',
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

  Widget _Profesi() {
    return Container(
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
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF828993),
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
        value: selectedProfesi,
        items: categoriesData.map((entry) {
          return DropdownMenuItem<String>(
            value: entry['name'].toString(),
            child: Text(entry['name'].toString()),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedProfesi = newValue!; // Ubah nilai yang terpilih
            print(newValue);
          });
        },
      ),
    );
  }

  changeListToStringSkill() {
    List<String> skillss = selectedSkillList;
    String skillString = skillss.join(':');
    return skillString;
  }

  Widget _Skill() {
    return Container(
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
                fontSize: 12,
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
              children: selectedSkillList.map((newValue) {
                return Chip(
                  label: Text(newValue),
                  labelStyle: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 10.5,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                  onDeleted: () {
                    setState(() {
                      selectedSkillList.remove(newValue);
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
                style: TextStyle(fontSize: 12),
              ),
              style: TextStyle(
                color: Color(0xFF828993),
                fontSize: 12,
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
              items: skillsData.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry['name'].toString(),
                  child: Text(entry['name'].toString()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedSkillList.add(newValue);
                    print(selectedSkillList);
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
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
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
      ),
    );
  }

  Widget _Deskripsi() {
    return Container(
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
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12,
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
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12,
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
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF828993),
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
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                  height: 1.7),
            ),
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Kisaran Gaji',
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
                color: Color(0xFF828993),
                fontSize: 12,
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
                    children: const [
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
                ),
        ),
      ),
    );
  }

  Widget _UploadSKB() {
    return Container(
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

  Widget _UploadSertifImg() {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: GestureDetector(
        onTap: _pickSertifImg,
        child: Center(
          child: selectedSertifImg == null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Upload Sertifikat Pengalaman',
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
                        'Sertifikat Pengalaman',
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
                        selectedSertifImg!,
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
            bool success = await pekerjaRegist.registerFifthPage(
              selectedProfesi.toString(),
              deskripsi,
              pengalaman,
              selectedPendidikan.toString(),
              gaji,
              changeListToStringSkill(),
            );
            bool successToo = await pekerjaRegist.registerSixthPage(
              selectedKTPImg!,
              selectedSKBImg!,
              selectedHalfImg!,
              selectedFullImg!,
              selectedSertifImg!,
            );
            if (success && successToo) {
              Navigator.pushNamed(context, '/login');
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
                fontSize: 12,
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

  void _pickSertifImg() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedSertifImg = File(pickedImage.path);
      });
    }
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

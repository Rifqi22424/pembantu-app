// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prt/src/api/fetch_data.dart';
import 'package:prt/src/api/regist_pekerja_model.dart';
import 'package:prt/src/mixins/validation_mixin.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';
import 'package:path/path.dart' as path;

class RegistPekerjaPengalaman extends StatefulWidget {
  const RegistPekerjaPengalaman({super.key});

  @override
  State<RegistPekerjaPengalaman> createState() =>
      _RegistPekerjaPengalamanState();
}

class _RegistPekerjaPengalamanState extends State<RegistPekerjaPengalaman>
    with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  TextEditingController _controller = TextEditingController();
  TextEditingController gajiController = TextEditingController();
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

  bool selectedKTPImgErr = false;
  bool selectedSKBImgErr = false;
  bool selectedHalfImgErr = false;
  bool selectedFullImgErr = false;
  // bool selectedSertifImgErr = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    authToken = '1|wLQRRxEnI5e4U6LMb6dUn49LJovzoUwKy8rUq9lh66972726';
    id = '1';
    pekerjaRegist = RegistPekerjaModel();
    fetchData = FetchData(id);
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
                          _profesi(),
                          SizedBox(height: 12),
                          _skill(),
                          SizedBox(height: 6),
                          _infoSkillText(),
                          SizedBox(height: 12),
                          _deskripsi(),
                          SizedBox(height: 12),
                          _pengalaman(),
                          SizedBox(height: 12),
                          _pendidikan(),
                          SizedBox(height: 12),
                          _gaji(),
                          SizedBox(height: 12),
                          _uploadKTP(),
                          (selectedKTPImgErr)
                              ? textNonNull()
                              : SizedBox(height: 12),
                          _uploadSKB(),
                          (selectedSKBImgErr)
                              ? textNonNull()
                              : SizedBox(height: 12),
                          _uploadHalfImg(),
                          (selectedHalfImgErr)
                              ? textNonNull()
                              : SizedBox(height: 12),
                          _uploadFullImg(),
                          (selectedFullImgErr)
                              ? textNonNull()
                              : SizedBox(height: 12),
                          _uploadSertifImg(),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/registpekerjadatadiri');
            },
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
          Column(
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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/registpekerjakontaklain');
            },
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
          Column(
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
        ],
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

  Widget _profesi() {
    return DropdownButtonFormField<String>(
      validator: validateNonNull,
      icon: Image.asset('images/option.png'),
      style: TextStyle(
        color: Color(0xFF828993),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),
      decoration: InputDecoration(
        labelText: 'Profesi',
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Warna border
              width: 2.0, // Lebar border
            ),
            borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        labelStyle: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
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
    );
  }

  changeListToStringSkill() {
    List<String> skillss = selectedSkillList;
    String skillString = skillss.join(':');
    return skillString;
  }

  Widget _skill() {
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
                final skillName = entry['name'].toString();
                // Periksa apakah skill sudah ada dalam selectedSkillList
                final isSkillSelected = selectedSkillList.contains(skillName);
                return DropdownMenuItem<String>(
                  value: skillName,
                  child: Text(skillName),
                  enabled: !isSkillSelected,
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null && !selectedSkillList.contains(newValue)) {
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

  Widget _infoSkillText() {
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
          ),
        ),
      ),
    );
  }

  Widget _deskripsi() {
    return SizedBox(
      child: TextFormField(
        validator: validateNonNull,
        keyboardType: TextInputType.multiline,
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\n'))],
        decoration: InputDecoration(
          labelText: 'Deskripsi',
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
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
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
        minLines: 5,
        maxLines: 5,
      ),
    );
  }

  Widget _pengalaman() {
    return SizedBox(
      child: Stack(
        children: [
          TextFormField(
            validator: validateNonNull,
            decoration: InputDecoration(
              labelText: 'Pengalaman Bekerja',
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
                fontSize: 12,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.7,
              ),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color(0xFF828993),
              fontSize: 12,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(2)],
            onSaved: (String? value) {
              pengalaman = value!;
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20, top: 8),
              child: Text(
                'tahun',
                style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pendidikan() {
    return SizedBox(
      child: DropdownButtonFormField<String>(
        validator: validateNonNull,
        icon: Image.asset('images/option.png'),
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        decoration: InputDecoration(
          labelText: 'Pendidikan Terakhir',
          labelStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue, // Warna border
                width: 2.0, // Lebar border
              ),
              borderRadius: BorderRadius.circular(32)),
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

  Widget _gaji() {
    return SizedBox(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 14),
              child: Text(
                'Rp.',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          TextFormField(
            validator: validateNonNull,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              labelText: 'Kisaran Gaji',
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Warna border
                    width: 2.0, // Lebar border
                  ),
                  borderRadius: BorderRadius.circular(32)),
              contentPadding: EdgeInsets.only(left: 50.0, right: 16.0),
              labelStyle: TextStyle(
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
            controller: gajiController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction(
                (oldValue, newValue) {
                  final numericValue = int.tryParse(newValue.text);
                  if (numericValue != null) {
                    final formattedValue = NumberFormat.decimalPattern('vi_VN')
                        .format(numericValue);
                    return TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                          offset: formattedValue.length),
                    );
                  }
                  return newValue;
                },
              ),
            ],
            onSaved: (String? value) {
              gaji = gajiController.text.replaceAll('.', '');
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20, top: 14),
              child: Text(
                '/ perbulan',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
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

  Widget _uploadSKB() {
    return InkWell(
      onTap: _pickSKBImg,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: (selectedSKBImgErr)
              ? Color.fromARGB(255, 255, 222, 222)
              : Color(0xFFF5F5F5),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Center(
            child: selectedSKBImg == null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'Upload Surat Kelakuan Baik',
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

  Widget _uploadFullImg() {
    return InkWell(
      onTap: _pickFullImg,
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: (selectedFullImgErr)
              ? Color.fromARGB(255, 255, 222, 222)
              : Color(0xFFF5F5F5),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Center(
            child: selectedFullImg == null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'Upload Foto Satu Badan',
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

  Widget _uploadSertifImg() {
    return InkWell(
      onTap: _pickSertifImg,
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
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

  Widget textNonNull() {
    return Column(
      children: [
        SizedBox(height: 6),
        Text(
          'Isi data diatas terlebih dahulu',
          style: TextStyle(
            color: Colors.redAccent[700],
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        SizedBox(height: 6),
      ],
    );
  }

  Widget submitButton() {
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
        print(deskripsi);
        formKey.currentState!.validate();
        isFotoNull();
        formKey.currentState!.save();

        if (selectedProfesi == null ||
            selectedSkillList == [] ||
            deskripsi == '' ||
            pengalaman == '' ||
            selectedPendidikan == null ||
            gaji == '' ||
            selectedKTPImg == null ||
            selectedSKBImg == null ||
            selectedHalfImg == null ||
            selectedFullImg == null ||
            selectedSertifImg == null) {
          _showTopSnackbar(context, "Lengkapi data terlebih dahulu", false);
        } else {
          try {
            setState(() {
              isLoading = true;
            });
            bool success = await pekerjaRegist.registerFifthPage(
              selectedProfesi.toString(),
              deskripsi,
              pengalaman,
              selectedPendidikan.toString(),
              gaji,
              changeListToStringSkill(),
            );
            File compressedKTPImg = await compressImage(selectedKTPImg!);
            File compressedSKBImg = await compressImage(selectedSKBImg!);
            File compressedHalfImg = await compressImage(selectedHalfImg!);
            File compressedFullImg = await compressImage(selectedFullImg!);
            File compressedSertifImg = await compressImage(selectedSertifImg!);

            bool successToo = await pekerjaRegist.registersSixthPage(
              compressedKTPImg,
              compressedSKBImg,
              compressedHalfImg,
              compressedFullImg,
              compressedSertifImg,
            );
            if (success && successToo) {
              Navigator.pushNamed(context, '/login');
              _showTopSnackbar(context, "Data berhasil tersimpan", true);

              setState(() {
                isLoading = false;
              });
            }
          } catch (e) {
            print('Error: $e');
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
    );
  }

  void checkAndSetError(bool condition, Function(bool) setStateError) {
    setState(() {
      setStateError(condition);
    });
  }

  void isFotoNull() {
    checkAndSetError(
        selectedKTPImg == null, (value) => selectedKTPImgErr = value);
    checkAndSetError(
        selectedSKBImg == null, (value) => selectedSKBImgErr = value);
    checkAndSetError(
        selectedHalfImg == null, (value) => selectedHalfImgErr = value);
    checkAndSetError(
        selectedFullImg == null, (value) => selectedFullImgErr = value);
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

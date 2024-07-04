// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/api/regist_pekerja_model.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';
import '../../../main.dart';

class EditProfilePekerjaPage extends StatefulWidget {
  const EditProfilePekerjaPage({super.key});

  @override
  State<EditProfilePekerjaPage> createState() => _EditProfilePekerjaPageState();
}

class _EditProfilePekerjaPageState extends State<EditProfilePekerjaPage> {
  UserProfile? userProfile;
  late RegistPekerjaModel postService;
  final formKey = GlobalKey<FormState>();
  File? selectedHalfImg;
  String gmail = '';
  String name = '';
  String notelp = '';
  String alamat = '';
  String gaji = '';
  TextEditingController alamatGmailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController gajiController = TextEditingController();
  bool isLoading = false;

  Future<void> fetchUserProfileData() async {
    try {
      UserProfile user = await fetchUserProfile();
      setState(() {
        userProfile = user;
        if (userProfile != null) {
          final formattedValue =
                    NumberFormat.decimalPattern('vi_VN').format(int.parse(userProfile!.profile["gaji"].toString()));
          alamatGmailController.text = userProfile!.email;
          nameController.text = userProfile!.profile["nama_lengkap"];
          gajiController.text = formattedValue;
          alamatController.text = userProfile!.profile["alamat_sekarang"];
          notelpController.text = userProfile!.profile["no_telp"];
        }
      });
      print("nama ${nameController.text}");
      print("gaji ${gajiController.text}");
      print("alamat ${alamatController.text}");
      print("notelp ${notelpController.text}");
      print("alamatt ${userProfile!.profile["alamat_sekarang"]}");
    } catch (e) {
      print('Error fetching user profile: $e');
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

  @override
  void initState() {
    super.initState();
    fetchUserProfileData();
    postService = RegistPekerjaModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: userProfile == null
          ? Center(child: CircularProgressIndicator(color: Color(0xFF39810D)))
          : ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      title(),
                      back(context),
                    ],
                  ),
                  SizedBox(height: 50),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        _editPhotoProfile(),
                        SizedBox(height: 80),
                        // _gmail(),
                        SizedBox(height: 20),
                        _name(),
                        SizedBox(height: 20),
                        _alamat(),
                        SizedBox(height: 20),
                        _notelp(),
                        SizedBox(height: 20),
                        _gaji(),
                        SizedBox(height: 70),
                        submitButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _editPhotoProfile() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: _pickHalfImg,
        child: Center(
          child: selectedHalfImg == null
              ? Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                '$serverPath${userProfile!.profile["foto_setengah_badan"]}'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken)),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Color(0xFF828993),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(selectedHalfImg!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken)),
                          shape: BoxShape.circle),
                    ),
                    Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Color(0xFF828993),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  back(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 60),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 30,
              height: 30,
              padding: EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Image.asset('images/NavBackTransparant.png'),
            ),
          ),
        ],
      ),
    );
  }

  Center title() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 65),
          child: Text(
            'Detail Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }

  _gmail() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        controller: alamatGmailController,
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'Masukan Gmail',
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
          gmail = value!;
        },
      ),
    );
  }

  Widget _name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: nameController,
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: 'Masukan Nama Lengkap',
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue, // Warna border
                width: 2.0, // Lebar border
              ),
              borderRadius: BorderRadius.circular(32)),
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
          name = value!;
        },
      ),
    );
  }

  Widget _alamat() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: alamatController,
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: 'Alamat',
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
        onSaved: (String? value) {
          notelp = value!;
        },
      ),
    );
  }

  Widget _notelp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: notelpController,
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'No Telp',
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
        onSaved: (String? value) {
          alamat = value!;
        },
      ),
    );
  }

  Widget _gaji() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: gajiController,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: 'Gaji',
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
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          TextInputFormatter.withFunction(
            (oldValue, newValue) {
              final numericValue = int.tryParse(newValue.text);
              if (numericValue != null) {
                final formattedValue =
                    NumberFormat.decimalPattern('vi_VN').format(numericValue);
                return TextEditingValue(
                  text: formattedValue,
                  selection:
                      TextSelection.collapsed(offset: formattedValue.length),
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
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            try {
              isLoading = true;
              bool photoSuccess;

              if (selectedHalfImg != null) {
                photoSuccess =
                    await postService.updateProfilePhoto(selectedHalfImg!);
              } else {
                photoSuccess = false;
              }
              bool success = await postService.updateProfileText(nameController.text, notelpController.text, alamatController.text, gaji);

              if (success || photoSuccess) {
                _showTopSnackbar(context, "Upload Berhasil", true);
                Navigator.of(context).pop();
                isLoading = false;
              }
            } catch (e) {
              _showTopSnackbar(context, e.toString(), false);
              isLoading = false;
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
                'Update Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Inter',
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
}

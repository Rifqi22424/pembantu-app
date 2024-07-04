// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/api/regist_pekerja_model.dart';
import '../../../main.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
  TextEditingController notelpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController gajiController = TextEditingController();

  Future<void> fetchUserProfileData() async {
    try {
      UserProfile user = await fetchUserProfile();
      setState(() {
        userProfile = user;
        if (userProfile != null) {
          alamatGmailController.text = userProfile!.email;
          nameController.text = userProfile!.profile["nama_lengkap"];
          gajiController.text = userProfile!.profile["gaji"].toString();
          alamatController.text = userProfile!.profile["alamat_sekarang"];
          notelpController.text = userProfile!.profile["no_telp"];
        }
      });
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: userProfile == null
          ? Center(child: CircularProgressIndicator(color: Color(0xFF39810D)))
          : Container(
              height: screenHeight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Expanded(
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
                      child: Expanded(
                        child: Column(
                          children: [
                            _editPhotoProfile(),
                            SizedBox(height: 80),
                            _buildTextField(
                              controller: alamatGmailController,
                              label: 'Masukan Gmail',
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: nameController,
                              label: 'Masukan Nama Lengkap',
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: alamatController,
                              label: 'Alamat Sekarang',
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: notelpController,
                              label: 'No. Telp',
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: gajiController,
                              label: 'Gaji',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                    final numericValue =
                                        int.tryParse(newValue.text);
                                    if (numericValue != null) {
                                      final formattedValue =
                                          NumberFormat.decimalPattern('vi_VN')
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
                            ),
                            Spacer(),
                            submitButton(),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
          padding: EdgeInsets.only(top: 70),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, // Border color
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        labelStyle: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.7,
        ),
      ),
      inputFormatters: inputFormatters,
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
        minimumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 60)),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          try {
            bool photoSuccess;

            if (selectedHalfImg != null) {
              photoSuccess =
                  await postService.updateProfilePhoto(selectedHalfImg!);
            } else {
              photoSuccess = false;
            }
            bool success =
                await postService.updateProfileText(name, notelp, alamat, gaji);

            if (success || photoSuccess) {
              _showTopSnackbar(context, "Upload Berhasil", true);
            }
          } catch (e) {
            _showTopSnackbar(context, e.toString(), false);
          }
        }
      },
      child: Text(
        'Update Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
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

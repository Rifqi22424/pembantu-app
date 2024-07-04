// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prt/src/api/auth_model.dart';
import 'package:prt/src/api/push_notif.dart';
import 'package:prt/src/database/shared_preferences.dart';
import 'package:prt/src/mixins/validation_mixin.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  final Auth authService = Auth();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  String email = '';
  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: deviceTypeTablet() ? 340 : screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 25),
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    selamatDatangText(),
                    SizedBox(height: 16),
                    longText(),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        emailField(),
                        SizedBox(height: 12),
                        passwordField(),
                        SizedBox(height: 8),
                        forgetText(),
                        SizedBox(height: 30),
                        submitButton(),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  loginWith(),
                  SizedBox(height: 26),
                  googleNFacebook(),
                  SizedBox(height: 22),
                  dontHaveAcc(),
                  SizedBox(height: screenHeight * 0.02)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  longText() {
    return Text(
      'Kami senang melihat kamu lagi, untuk menggunakan akun, masuk terlebih dahulu',
      style: TextStyle(
        color: Color(0xFF828892),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.70,
      ),
    );
  }

  selamatDatangText() {
    return Text(
      'Selamat Datang 👋',
      style: TextStyle(
        color: Color(0xFF080B11),
        fontSize: 22,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  forgetText() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return overlayUnderMaintanance(context);
            },
          );
          print("tapped");
        },
        child: Text(
          'Forget password',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 10,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  dontHaveAcc() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(
              color: Color(0xFF828993),
              fontSize: 10,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: "Sign up",
            style: TextStyle(
              color: Color(0xFF38800C),
              fontSize: 10,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/regist');
              },
          ),
        ],
      ),
    );
  }

  googleNFacebook() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return overlayUnderMaintanance(context);
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  )),
              width: 150,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/GoogleLogo.png',
                    width: 22,
                    height: 22,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Google',
                    style: TextStyle(
                      color: Color(0xFF828993),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 24),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return overlayUnderMaintanance(context);
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  )),
              width: 150,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/FacebookLogo.png',
                    width: 22,
                    height: 22,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Facebook',
                    style: TextStyle(
                      color: Color(0xFF828993),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  loginWith() {
    return Row(
      children: const [
        Expanded(child: Divider(color: Colors.grey)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Login with',
            style: TextStyle(
              color: Color(0xFF828993),
              fontSize: 10,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey)),
      ],
    );
  }

  Padding forgotField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 24.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          'Forgot password',
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 10,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      validator: validateEmail,
      controller: emailController,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.71,
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Masukkan email',
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
      // validator: validateEmail,
      onSaved: (String? value) {
        email = value!;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      validator: validatePassword,
      controller: passwordController,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.71,
      ),
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          labelText: 'Password',
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue, // Warna border
                width: 2.0, // Lebar border
              ),
              borderRadius: BorderRadius.circular(32)),
          labelStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.71,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          )),
      // validator: validatePassword,
      onSaved: (String? value) {
        password = value!;
      },
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
        String? deviceToken = await getDeviceTokenFromSharedPreferences();
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          if (email == '' || password == '') {
            _showTopSnackbar(context, "Lengkapi data terlebih dahulu");
          } else {
            try {
              setState(() {
                isLoading = true;
              });

              Map<String, dynamic> data = await authService.login(
                email,
                password,
              );
              if (data['id'] != "" || data['id'] != null) {
                final int id = data['id'];
                final String token = data['token'];
                final String role = data['role'];

                await saveIdToSharedPreferences(id);
                await FirebaseNotifAPI().putToken(deviceToken!);
                await saveTokenToSharedPreferences(token);
                await saveRoleToSharedPreferences(role);
                print(role);
                if (role == 'majikan') {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                  setState(() {
                    isLoading = false;
                  });
                } else if (role == 'pekerja') {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/homepekerja', (route) => false);
                  setState(() {
                    isLoading = false;
                  });
                }
              }
            } catch (e) {
              print(e.toString());
              _showTopSnackbar(
                  context, e.toString().replaceFirst('Exception: ', ''));
              setState(() {
                isLoading = false;
              });
            }
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
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  void _showTopSnackbar(BuildContext context, String text) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Color(0xFFFF2222), // Warna latar belakang
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    // Hilangkan Snackbar setelah beberapa detik (opsional)
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  AlertDialog overlayUnderMaintanance(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      content: Container(
        width: 350,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 5.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                deleteButton(context),
                // Image.asset('images/check.png', width: 70, height: 70),
                Icon(
                  Icons.construction,
                  color: Colors.amber[900],
                  size: 70,
                ),
                SizedBox(height: 22),
                const Text(
                  'Dalam Pengembangan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 18,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 22),
                const Text(
                  'Mohon untuk melakukan registrasi atau login menggunakan autentikasi manual.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.71,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close)),
    );
  }
}

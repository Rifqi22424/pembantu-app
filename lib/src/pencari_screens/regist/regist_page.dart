// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prt/src/api/auth_model.dart';
import 'package:prt/src/database/shared_preferences.dart';
import 'package:prt/src/mixins/validation_mixin.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> with ValidationMixin {
  final Auth authService = Auth();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String gmail = '';
  String nomorhp = '';
  String password = '';
  String confirmPassword = '';

  bool gmailErr = false;
  bool nomorhpErr = false;
  bool passwordErr = false;
  bool confirmPasswordErr = false;

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
              SizedBox(height: screenHeight * 0.1),
              topText(),
              SizedBox(height: screenHeight * 0.06),
              Expanded(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gmailField(),
                      SizedBox(height: 12),
                      // (gmailErr) ? gmailError() : SizedBox(height: 12),
                      noHpField(),
                      SizedBox(height: 12),
                      // (nomorhpErr) ? nomorHpError() : SizedBox(height: 12),
                      passwordField(),
                      SizedBox(height: 12),
                      // (passwordErr) ? passwordError() : SizedBox(height: 12),
                      confirmPassField(),
                      SizedBox(height: 12),
                      // (confirmPasswordErr)
                      // ? confirmPasswordError()
                      // : SizedBox(height: 20),
                      // ButtonBuilder(
                      //     onPressed: () async {
                      //       validation();
                      //       await pushToApi();
                      //     },
                      //     label: "Sign Up"),
                      submitButton(),
                      Spacer(),
                      signupWith(),
                      SizedBox(height: 24),
                      googleNFacebook(),
                      SizedBox(height: 20),
                      haveAcc(),
                      SizedBox(height: screenHeight * 0.02),
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

  gmailError() {
    final email = emailController.text;
    final emailError = validateEmail(email);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            '*$emailError!',
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

  confirmPasswordError() {
    final passConfirm = passwordConfirmController.text;
    final pass = passwordController.text;
    final confirmPassErr = validateConfirmPassword(passConfirm, pass);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            '*$confirmPassErr!',
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

  nomorHpError() {
    final noHp = phoneController.text;
    final phoneErr = validatePhone(noHp);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            '*$phoneErr!',
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

  passwordError() {
    final pass = passwordController.text;
    final passErr = validatePassword(pass);
    return Row(
      children: [
        SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            '*$passErr!',
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

  topText() {
    return Column(
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
          'Kami senang melihat kamu, silahkan daftar terlebih dahulu',
          style: TextStyle(
            color: Color(0xFF828892),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.70,
          ),
        ),
      ],
    );
  }

  haveAcc() {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "You have an account? ",
              style: TextStyle(
                color: Color(0xFF828993),
                fontSize: 10,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
                text: "Login",
                style: TextStyle(
                  color: Color(0xFF38800C),
                  fontSize: 10,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w700,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/login');
                  }),
          ],
        ),
      ),
    );
  }

  googleNFacebook() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return overlayScheduleSuccess(context);
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
              child: Container(
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
        ),
        SizedBox(width: 24),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return overlayScheduleSuccess(context);
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
              child: Container(
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
        ),
      ],
    );
  }

  Row signupWith() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Sign up with',
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

  Padding ForgotField() {
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

  Widget gmailField() {
    return TextFormField(
      validator: validateEmail,
      controller: emailController,
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
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.71,
      ),
      onSaved: (String? value) {
        gmail = value!;
      },
    );
  }

  Widget noHpField() {
    return TextFormField(
      validator: validatePhone,
      controller: phoneController,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.71,
      ),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'No. Handphone',
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
        nomorhp = value!;
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
      keyboardType: TextInputType.visiblePassword,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
          labelText: 'Password',
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
            height: 1.71,
          ),
          suffixIcon: IconButton(
            iconSize: 22,
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

  Widget confirmPassField() {
    return TextFormField(
      validator: (value) =>
          validateConfirmPassword(value, passwordController.text),
      controller: passwordConfirmController,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.71,
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
          labelText: 'Retype Password',
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
            height: 1.71,
          ),
          suffixIcon: IconButton(
            iconSize: 22,
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
        confirmPassword = value!;
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
        validation();
        await pushToApi();
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
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  Future<void> pushToApi() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        setState(() {
          isLoading = true;
        });
        int id = await authService.register(
          gmail,
          nomorhp,
          password,
          confirmPassword,
        );

        await saveIdToSharedPreferences(id);
        Navigator.pushNamed(context, '/verif', arguments: {'gmail': gmail});
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        _showTopSnackbar(context, e.toString().replaceFirst('Exception: ', ''));
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void validation() {
    final email = emailController.text;
    final emailError = validateEmail(email);
    final noHp = phoneController.text;
    final noHpError = validatePhone(noHp);
    final password = passwordController.text;
    final passwordError = validatePassword(password);
    final confirmPass = passwordConfirmController.text;
    final confirmPassError = validateConfirmPassword(confirmPass, password);

    setState(() {
      gmailErr = emailError != null;
      nomorhpErr = noHpError != null;
      passwordErr = passwordError != null;
      confirmPasswordErr = confirmPassError != null;
    });

    FocusScope.of(context).unfocus();
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

  AlertDialog overlayScheduleSuccess(BuildContext context) {
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
    // return GestureDetector(
    //   onTap: () {
    //     Navigator.of(context).pop();
    //   },
    //   child: Align(
    //     alignment: Alignment.topRight,
    //     child: Image.asset('images/xNoBG.png', width: 16, height: 16),
    //   ),
    // );
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close)),
    );
  }
}

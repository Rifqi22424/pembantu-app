// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prt/src/models/auth_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  final Auth authService = Auth();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String username = '';
  String nomorhp = '';
  String password = '';

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
                    children: [
                      UsernameField(),
                      SizedBox(height: 12),
                      NoHpField(),
                      SizedBox(height: 12),
                      passwordField(),
                      SizedBox(height: 12),
                      confirmPassField(),
                      SizedBox(height: 20),
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
    return Text.rich(
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
    );
  }

  googleNFacebook() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
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
        SizedBox(width: 24),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
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

  Widget UsernameField() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'Username',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          hintStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.71,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 14,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        onSaved: (String? value) {
          username = value!;
        },
      ),
    );
  }

  Widget NoHpField() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        controller: phoneController,
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 14,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        decoration: InputDecoration(
          hintText: 'No. Hp',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          hintStyle: TextStyle(
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
      ),
    );
  }

  Widget passwordField() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(32))),
      child: TextFormField(
        controller: passwordController,
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 14,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
            hintText: 'Password',
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            hintStyle: TextStyle(
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
      ),
    );
  }

  Widget confirmPassField() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(32))),
      child: TextFormField(
        controller: passwordConfirmController,
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 14,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
            hintText: 'Retype Password',
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            hintStyle: TextStyle(
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
      onPressed:

          // () async {
          //   try {
          //     bool registered = await authService.register(
          //       emailController.text,
          //       phoneController.text,
          //       passwordController.text,
          //       passwordConfirmController.text,
          //     );
          //     if (registered) {
          //       formKey.currentState!.save();
          //       print('post $username, $nomorhp and $password');
          //       Navigator.pushNamed(context, '/verif');
          //     } else {
          //       print('Something wrong');
          //     }
          //   } catch (e) {
          //     print('error $e');
          //   }
          // },

          () {
        formKey.currentState!.save();
        print('post $username, $nomorhp and $password');
        Navigator.pushNamed(context, '/verif');
      },
      child: Text('Sign Up'),
    );
  }
}

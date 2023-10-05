// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prt/src/models/auth_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class LoginPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Auth authService = Auth();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  String email = '';
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
                        SizedBox(height: screenHeight * 0.18)
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

  Align forgetText() {
    return Align(
      alignment: Alignment.centerRight,
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
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profilepekerja');
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
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/incomingcall');
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
      ),
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
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
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
          hintText: 'example@gmail.com',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(
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
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.71,
        ),
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
            hintText: 'Password',
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            hintStyle: TextStyle(
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
          //     bool login = await authService.login(
          //       emailController.text,
          //       passwordController.text,
          //     );
          //     if (login) {
          //       formKey.currentState!.save();
          //       print('Time to post $email and $password to my API');
          //       Navigator.pushNamed(context, '/home');
          //     } else {
          //       print('something wrong');
          //     }
          //   } catch (e) {
          //     print('this $e');
          //   }
          // },

          () {
        formKey.currentState!.save();
        print('Time to post $email and $password to my API');
        Navigator.pushNamed(context, '/home');
      },
      child: Text(
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
}

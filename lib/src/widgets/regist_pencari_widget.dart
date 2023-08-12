import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prt/src/screens/login_page.dart';
import 'package:prt/src/screens/verif_page.dart';
import '../mixins/validation_mixin.dart';

class RegistPencariWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<RegistPencariWidget> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  String username = '';
  String nomorhp = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
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
            ConfirmPassField(),
            SizedBox(height: 20),
            submitButton(),
            SizedBox(height: 60),
            loginWith(),
            SizedBox(height: 24),
            GoogleNFacebook(),
            SizedBox(height: 20),
            HaveAcc(),
          ],
        ),
      ),
    );
  }

  Text HaveAcc() {
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }),
        ],
      ),
    );
  }

  Container GoogleNFacebook() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
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
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 24),
          Container(
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
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row loginWith() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Username',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(fontSize: 12.5),
        ),
        onSaved: (String? value) {
          username = value!;
        },
      ),
    );
  }

  Widget NoHpField() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'No. Hp',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(fontSize: 12.5),
        ),
        onSaved: (String? value) {
          nomorhp = value!;
        },
      ),
    );
  }

  Widget passwordField() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(32))),
      child: TextFormField(
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
            hintText: 'Password',
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            hintStyle: TextStyle(fontSize: 12.5),
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
        validator: validatePassword,
        onSaved: (String? value) {
          password = value!;
        },
      ),
    );
  }

  Widget ConfirmPassField() {
    return Container(
      width: 320,
      height: 54,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(32))),
      child: TextFormField(
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
            hintText: 'Retype Password',
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            hintStyle: TextStyle(fontSize: 12.5),
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
        validator: validatePassword,
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
        minimumSize: MaterialStateProperty.all<Size>(Size(320, 50)),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          print('post $username, $nomorhp and $password');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => VerifPage()));
        }
      },
      child: Text('Sign Up'),
    );
  }
}

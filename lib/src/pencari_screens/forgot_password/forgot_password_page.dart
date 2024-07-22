import 'package:flutter/material.dart';
import 'package:prt/src/mixins/validation_mixin.dart';

import '../../api/auth_model.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final Auth authService = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left:  24, right: 24, bottom: 12),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 24),
                emailField(),
                // SizedBox(height: 12),
                Spacer(),
                submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton submitButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 54)),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          try {
            setState(() {
              isLoading = true;
            });

            bool success =
                await authService.forgotPassword(emailController.text);

            if (success) {
              setState(() {
                isLoading = false;
              });
              _showTopSnackbar(context, "Silahkan Cek Gmail Anda", true);
            }
          } catch (e) {
            print(e.toString());
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
              'Submit',
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

  TextFormField emailField() {
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
      // onSaved: (String? value) {
      //   email = value!;
      // },
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        "Forgot Password",
        style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w600,
            ),
      ),
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
      ),
    );
  }
}

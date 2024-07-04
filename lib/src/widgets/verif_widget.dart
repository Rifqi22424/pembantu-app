// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/api/auth_model.dart';

class VerifCodeInput extends StatefulWidget {
  final VoidCallback onVerificationSuccess;
  const VerifCodeInput({Key? key, required this.onVerificationSuccess})
      : super(key: key);

  @override
  State<VerifCodeInput> createState() => _VerifCodeInputState();
}

class _VerifCodeInputState extends State<VerifCodeInput> {
  List<FocusNode> focusNodes = [];
  final Auth authService = Auth();
  List<TextEditingController> controllers = [];
  int numberOfFields = 4;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numberOfFields,
        (index) {
          return Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              keyboardType: TextInputType.number,
              maxLength: 1,
              onChanged: (value) => _onFieldChanged(value, index),
              decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.only(left: 18),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < numberOfFields; i++) {
      focusNodes.add(FocusNode());
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < numberOfFields; i++) {
      focusNodes[i].dispose();
      controllers[i].dispose();
    }
    super.dispose();
  }

  Future<void> _onFieldChanged(String value, int index) async {
    if (value.isNotEmpty) {
      if (index < numberOfFields - 1) {
        focusNodes[index + 1].requestFocus();
      }
    }

    bool allFieldsFilled = true;
    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        allFieldsFilled = false;
        break;
      }
    }

    if (allFieldsFilled) {
      final List<String> verificationCode =
          controllers.map((controller) => controller.text).toList();
      final String combinedCode = verificationCode.join();
      print(combinedCode);
      try {
        bool success = await authService.sendVerificationCode(
          combinedCode,
        );
        if (success) {
          widget.onVerificationSuccess();
        }
      } catch (e) {
        print('Error: $e');
        _showTopSnackbar(context, e.toString().replaceFirst('Exception: ', ''));
      }
    }
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
}

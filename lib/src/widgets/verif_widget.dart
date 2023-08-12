import 'package:flutter/material.dart';

class VerifCodeInput extends StatefulWidget {
  final VoidCallback onVerificationSuccess;
  const VerifCodeInput({Key? key, required this.onVerificationSuccess})
      : super(key: key);

  @override
  State<VerifCodeInput> createState() => _VerifCodeInputState();
}

class _VerifCodeInputState extends State<VerifCodeInput> {
  List<FocusNode> focusNodes = [];
  List<TextEditingController> controllers = [];
  int numberOfFields = 4;

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

  void _onFieldChanged(String value, int index) {
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
      widget.onVerificationSuccess();
    }
  }

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
}

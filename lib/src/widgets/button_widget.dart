import 'package:flutter/material.dart';

class ButtonBuilder extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;

  const ButtonBuilder({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  State<ButtonBuilder> createState() => _ButtonBuilderState();
}

class _ButtonBuilderState extends State<ButtonBuilder> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
        setState(() {
          isLoading =
              true; // Set isLoading to true to show CircularProgressIndicator
        });

        if (widget.onPressed != null) {
          widget.onPressed!(); // Execute the provided onPressed function

          setState(() {
            isLoading =
                false; // Set isLoading back to false after onPressed completes
          });
        }
      },
      child: isLoading
          ? CircularProgressIndicator()
          : Text(
              widget.label,
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

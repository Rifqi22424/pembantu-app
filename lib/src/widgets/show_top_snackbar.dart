import 'package:flutter/material.dart';

void showTopSnackbar(BuildContext context, String text) {
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
                child: Center(
                  child: Text(
                    text,
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

    // Hilangkan Snackbar setelah beberapa detik (opsional)
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/api/regist_pekerja_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  bool isBoxPekerjaPressed = false;
  bool isBoxPencariPressed = false;
  String? role;
  late RegistPekerjaModel pekerjaRegist;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    pekerjaRegist = RegistPekerjaModel();
  }

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
          height: screenHeight,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.08),
              TopText(),
              SizedBox(height: 40),
              BoxPekerja(context),
              SizedBox(height: 12),
              BoxPencari(context),
              Spacer(),
              SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  InkWell BoxPencari(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isBoxPencariPressed = !isBoxPencariPressed;
          isBoxPekerjaPressed = false;
        });
      },
      child: Container(
        width: double.maxFinite,
        height: 220,
        padding: EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
          bottom: 16,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: isBoxPencariPressed ? Color(0xFF38800C) : Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              isBoxPencariPressed
                  ? 'images/pencariWhite.png'
                  : 'images/Pencari.png',
              width: 70,
              height: 70,
            ),
            SizedBox(height: 5),
            Text(
              'Mencari Pekerja',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isBoxPencariPressed ? Colors.white : Color(0xFF080B11),
                fontSize: 14,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Kamu Bisa Mencari Pekerja yang sesuai dengan kebutuhan anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isBoxPencariPressed ? Colors.white : Color(0xFF828993),
                fontSize: 12,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell BoxPekerja(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isBoxPekerjaPressed = !isBoxPekerjaPressed;
          isBoxPencariPressed = false;
        });
      },
      child: Container(
        width: double.maxFinite,
        height: 220,
        padding: EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
          bottom: 16,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: isBoxPekerjaPressed ? Color(0xFF38800C) : Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              isBoxPekerjaPressed
                  ? 'images/pembatuWhite.png'
                  : 'images/Pembantu.png',
              width: 70,
              height: 70,
            ),
            SizedBox(height: 5),
            Text(
              'Pekerja',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isBoxPekerjaPressed ? Colors.white : Color(0xFF080B11),
                fontSize: 14,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Cantumkan Profile data diri-Mu dan tunggu seseorang menghubungi-Mu',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isBoxPekerjaPressed ? Colors.white : Color(0xFF828993),
                fontSize: 12,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SubmitButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
          minimumSize:
              WidgetStateProperty.all<Size>(Size(double.maxFinite, 44)),
        ),
        onPressed: () async {
          print(role);
          if (isBoxPekerjaPressed) {
            role = 'pekerja'; // Ubah menjadi "2" jika isBoxPekerjaPressed aktif
          } else if (isBoxPencariPressed) {
            role = 'majikan'; // Ubah menjadi "1" jika isBoxPencariPressed aktif
          }

          if (isBoxPekerjaPressed == true || isBoxPencariPressed == true) {
            try {
              setState(() {
                isLoading = true;
              });
              bool success = await pekerjaRegist.registerFirstPage(role!);
              if (success) {
                if (isBoxPekerjaPressed) {
                  Navigator.pushNamed(context, '/registpekerjadatadiri');
                  setState(() {
                    isLoading = false;
                  });
                } else if (isBoxPencariPressed) {
                  Navigator.pushNamed(context, '/registpencaridatadiri');
                  setState(() {
                    isLoading = false;
                  });
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Pilih salah satu dari role diatas')));
                setState(() {
                  isLoading = false;
                });
              }
            } catch (e) {
              print('Error: $e');
              setState(() {
                isLoading = false;
              });
            }
          } else {
            _showTopSnackbar(context);
            setState(() {
              isLoading = false;
            });
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
                'Selanjutnya',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  TopText() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih salah satu',
            style: TextStyle(
              color: Color(0xFF080B11),
              fontSize: 22,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'ingin sebagai Pencari Pembantu, atau sebagai Pembantu',
            style: TextStyle(
              color: Color(0xFF828892),
              fontSize: 12,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
              height: 1.70,
            ),
          ),
        ],
      ),
    );
  }

  void _showTopSnackbar(BuildContext context) {
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
                  'Pilih salah satu role!',
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

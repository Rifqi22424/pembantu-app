// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/pencari_screens/login_page.dart';
import 'package:prt/src/pencari_screens/profile/edit_profile.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final bool approved = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: deviceTypeTablet() ? 340 : screenWidth,
              child: Stack(
                children: [
                  profileBackground(),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 70),
                        profileText(),
                        SizedBox(height: 24),
                        photoProfile(),
                        SizedBox(height: 26),
                        nameNGmailText(),
                        SizedBox(height: 16),
                        editProfileButton(),
                        SizedBox(height: 36),
                        Column(
                          children: [
                            berandaText(),
                            pembayaranText(),
                            alamatText(),
                            line(),
                            changePin(),
                            help(),
                            privation(),
                            syarat(),
                            logOut(),
                          ],
                        ),
                        SizedBox(height: 80),
                        versionText(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  approveAcc()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text versionText() {
    return Text(
      'Version beta 0.1',
      style: TextStyle(
        color: Color(0xFF828993),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  pembayaranText() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/transaction');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/dolarStack.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 12),
                Text(
                  'Pembayaran',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Image.asset(
              'images/NavNextNoBG.png',
              width: 26,
              height: 26,
            ),
          ],
        ),
      ),
    );
  }

  Container alamatText() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'images/location.png',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 12),
              Text(
                'Alamat',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Image.asset(
            'images/NavNextNoBG.png',
            width: 26,
            height: 26,
          ),
        ],
      ),
    );
  }

  line() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Divider(
        thickness: 1,
        color: Color(0XFFF2F2F2),
      ),
    );
  }

  changePin() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'images/key.png',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 12),
              Text(
                'Ubah Pin',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Image.asset(
            'images/NavNextNoBG.png',
            width: 26,
            height: 26,
          ),
        ],
      ),
    );
  }

  help() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'images/questionMark.png',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 12),
              Text(
                'Pusat Bantuan',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Image.asset(
            'images/NavNextNoBG.png',
            width: 26,
            height: 26,
          ),
        ],
      ),
    );
  }

  privation() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'images/exclamationMark.png',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 12),
              Text(
                'Kebijakan Privasi',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Image.asset(
            'images/NavNextNoBG.png',
            width: 26,
            height: 26,
          ),
        ],
      ),
    );
  }

  syarat() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 320,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'images/documentSign.png',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 12),
              Text(
                'Syarat dan Ketentuan',
                style: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Image.asset(
            'images/NavNextNoBG.png',
            width: 26,
            height: 26,
          ),
        ],
      ),
    );
  }

  logOut() {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/logoutSign.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 12),
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Image.asset(
              'images/NavNextNoBG.png',
              width: 26,
              height: 26,
            ),
          ],
        ),
      ),
    );
  }

  berandaText() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(context, '/home');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/HomePlain.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 12),
                Text(
                  'Beranda',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Image.asset(
              'images/NavNextNoBG.png',
              width: 26,
              height: 26,
            ),
          ],
        ),
      ),
    );
  }

  editProfileButton() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: MaterialStateProperty.all<Size>(Size(180, 50)),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EditProfilePage()));
      },
      child: Text(
        'Edit Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Column nameNGmailText() {
    return Column(
      children: const [
        Text(
          'Ana Blacklight',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 14,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'anablacklight23@gmail.com',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 10,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Container photoProfile() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
            width: 3,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Colors.white),
        image: DecorationImage(
            image: AssetImage('images/Emily.jpg'), fit: BoxFit.fill),
        shape: BoxShape.circle,
      ),
    );
  }

  Text profileText() {
    return Text(
      'Profil',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Padding approveAcc() {
    return Padding(
      padding: const EdgeInsets.only(top: 220.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: ShapeDecoration(
            color: Color(0xFFFFF5E6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                approved ? 'Approve' : 'Pendding',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: approved ? Color(0xFF479BFF) : Color(0xFFFFB84E),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  profileBackground() {
    return Container(
      height: 190,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/profileBG.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          )),
    );
  }
}

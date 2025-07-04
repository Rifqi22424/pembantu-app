// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/main.dart';
import 'package:prt/src/pencari_screens/login_page.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

import '../../api/fetch_user_data.dart';
import '../../database/shared_preferences.dart';

class ProfilePekerjaPage extends StatefulWidget {
  const ProfilePekerjaPage({super.key});

  @override
  State<ProfilePekerjaPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePekerjaPage> {
  final bool approved = false;
  bool isCekInterViewButtonPressed = false;

  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    fetchUserProfile().then((profile) {
      setState(() {
        userProfile = profile;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: userProfile == null
          ? loadingProfileContent()
          : ScrollConfiguration(
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
                              SizedBox(height: 16),
                              // Column(
                              //   children: [
                              //     beranda(),
                              //     pembayaran(),
                              //     cekInterview(),
                              //     cekInterviewchildren(),
                              //     setJadwal(),
                              //     alamat(),
                              //     line(),
                              //     changePin(),
                              //     help(),
                              //     privation(),
                              //     syarat(),
                              //     logOut(),
                              //   ],
                              // ),
                              ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  buildListTile(
                                    iconPath: 'images/HomePlain.png',
                                    title: 'Beranda',
                                    onTap: () async {
                                      String? role =
                                          await getRoleFromSharedPreferences();

                                      if (role == 'majikan') {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, '/home', (route) => false);
                                      } else if (role == 'pekerja') {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/homepekerja',
                                            (route) => false);
                                      }
                                    },
                                  ),
                                  buildListTile(
                                    iconPath: 'images/dolarStack.png',
                                    title: 'Pembayaran',
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/transactionpekerja');
                                    },
                                  ),
                                  buildListTile(
                                    iconPath: 'images/location.png',
                                    title: 'Alamat',
                                  ),
                                  line(),
                                  buildListTile(
                                    iconPath: 'images/key.png',
                                    title: 'Ubah Pin',
                                  ),
                                  buildListTile(
                                    iconPath: 'images/questionMark.png',
                                    title: 'Pusat Bantuan',
                                  ),
                                  buildListTile(
                                    iconPath: 'images/exclamationMark.png',
                                    title: 'Kebijakan Privasi',
                                  ),
                                  buildListTile(
                                    iconPath: 'images/documentSign.png',
                                    title: 'Syarat dan Ketentuan',
                                  ),
                                  buildListTile(
                                    iconPath: 'images/logoutSign.png',
                                    title: 'Log Out',
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return overlayScheduleSuccess(
                                              context);
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 80),
                              versionText(),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        approveAcc(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // loadingProfileContent() {
  //   final double screenWidth = MediaQuery.of(context).size.width;

  //   return ScrollConfiguration(
  //     behavior: NoGlowBehavior(),
  //     child: SingleChildScrollView(
  //       child: Center(
  //         child: SizedBox(
  //           width: deviceTypeTablet() ? 340 : screenWidth,
  //           child: Stack(
  //             children: [
  //               profileBackground(),
  //               Center(
  //                 child: Column(
  //                   children: [
  //                     SizedBox(height: 70),
  //                     profileText(),
  //                     SizedBox(height: 24),
  //                     photoProfileDefault(),
  //                     SizedBox(height: 26),
  //                     nameNGmailTextDefault(),
  //                     SizedBox(height: 16),
  //                     editProfileButton(),
  //                     SizedBox(height: 36),
  //                     Column(
  //                       children: [
  //                         beranda(),
  //                         pembayaran(),
  //                         cekInterview(),
  //                         cekInterviewchildren(),
  //                         setJadwal(),
  //                         alamat(),
  //                         line(),
  //                         changePin(),
  //                         help(),
  //                         privation(),
  //                         syarat(),
  //                         logOut(),
  //                       ],
  //                     ),
  //                     SizedBox(height: 80),
  //                     versionText(),
  //                     SizedBox(height: 20),
  //                   ],
  //                 ),
  //               ),
  //               approveAcc()
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  loadingProfileContent() {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ScrollConfiguration(
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
                      photoProfileDefault(),
                      SizedBox(height: 26),
                      nameNGmailTextDefault(),
                      SizedBox(height: 16),
                      editProfileButton(),
                      SizedBox(height: 16),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          buildListTile(
                            iconPath: 'images/HomePlain.png',
                            title: 'Beranda',
                            onTap: () {
                              Navigator.pushNamed(context, '/home');
                            },
                          ),
                          buildListTile(
                            iconPath: 'images/dolarStack.png',
                            title: 'Pembayaran',
                            onTap: () {
                              Navigator.pushNamed(context, '/transaction');
                            },
                          ),
                          buildListTile(
                            iconPath: 'images/location.png',
                            title: 'Alamat',
                          ),
                          line(),
                          buildListTile(
                            iconPath: 'images/key.png',
                            title: 'Ubah Pin',
                          ),
                          buildListTile(
                            iconPath: 'images/questionMark.png',
                            title: 'Pusat Bantuan',
                          ),
                          buildListTile(
                            iconPath: 'images/exclamationMark.png',
                            title: 'Kebijakan Privasi',
                          ),
                          buildListTile(
                            iconPath: 'images/documentSign.png',
                            title: 'Syarat dan Ketentuan',
                          ),
                          buildListTile(
                            iconPath: 'images/logoutSign.png',
                            title: 'Log Out',
                            // onTap: () async {
                            //   await saveTokenToSharedPreferences('deleted');
                            //   Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LoginPage()),
                            //     (Route<dynamic> route) => false,
                            //   );
                            // },
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 80),
                      versionText(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                approveAcc(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  nameNGmailTextDefault() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 22,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 231, 231, 231)),
        ),
        SizedBox(height: 6),
        Container(
            height: 16,
            width: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(255, 231, 231, 231))),
      ],
    );
  }

  Container photoProfileDefault() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
            width: 3,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Colors.white),
        image: DecorationImage(
            image: AssetImage('images/User.png'), fit: BoxFit.fill),
        shape: BoxShape.circle,
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

  pembayaran() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/transactionpekerja');
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

  cekInterview() {
    return InkWell(
      onTap: () {
        setState(() {
          isCekInterViewButtonPressed = !isCekInterViewButtonPressed;
        });
      },
      child: Container(
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/interviewTransparant.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 12),
                Text(
                  'Cek Interview',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            isCekInterViewButtonPressed
                ? Image.asset(
                    'images/option.png',
                    width: 26,
                    height: 26,
                  )
                : Image.asset(
                    'images/NavNextNoBG.png',
                    width: 26,
                    height: 26,
                  ),
          ],
        ),
      ),
    );
  }

  cekInterviewchildren() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isCekInterViewButtonPressed ? 144 : 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              upcomingButton(),
              SizedBox(height: 10),
              panddingButton(),
              SizedBox(height: 10),
              passButton(),
              SizedBox(height: 10),
              rejectButton(),
            ],
          ),
        ],
      ),
    );
  }

  rejectButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/reject");
      },
      child: Container(
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  'Reject',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 26),
              ],
            ),
          ],
        ),
      ),
    );
  }

  passButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/pass");
      },
      child: Container(
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  'Pass',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 26),
              ],
            ),
          ],
        ),
      ),
    );
  }

  panddingButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/pandding");
      },
      child: Container(
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  'Pandding',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 26),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell upcomingButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/upcoming");
      },
      child: Container(
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  'Upcoming',
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 26),
              ],
            ),
          ],
        ),
      ),
    );
  }

  setJadwal() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/setjadwal');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10, top: 10),
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/jadwalSet.png',
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 12),
                Text(
                  'Set Jadwal',
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

  Container alamat() {
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
    return InkWell(
      onTap: () {},
      child: Container(
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
      ),
    );
  }

  logOut() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return overlayScheduleSuccess(context);
          },
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
                  width: 22,
                  height: 22,
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

  buildListTile({
    required String iconPath,
    required String title,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: ListTile(
        onTap: onTap,
        // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Image.asset(
          iconPath,
          width: 22,
          height: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Color(0xFF828993),
        ),
      ),
    );
  }

  beranda() {
    return InkWell(
      onTap: () async {
        String? role = await getRoleFromSharedPreferences();

        if (role == 'majikan') {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else if (role == 'pekerja') {
          Navigator.pushNamedAndRemoveUntil(
              context, '/homepekerja', (route) => false);
        }
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
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: WidgetStateProperty.all<Size>(Size(180, 50)),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/editprofilepekerja");
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
      children: [
        Text(
          userProfile!.profile["nama_lengkap"],
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
          userProfile!.email,
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
            image: NetworkImage(
                '$serverPath${userProfile!.profile["foto_setengah_badan"]}'),
            fit: BoxFit.cover),
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

  AlertDialog overlayScheduleSuccess(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      content: Container(
        width: 350,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 5.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                deleteButton(context),
                Icon(
                  Icons.error_outline,
                  color: Colors.black,
                  size: 70,
                ),
                // Image.asset('images/check.png', width: 70, height: 70),
                SizedBox(height: 22),
                const Text(
                  'Apakah Anda yakin ingin keluar dari akun?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 18,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        await saveTokenToSharedPreferences('deleted');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Material(
                        color: Color(0xFFFF2222).withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Ya",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Color(0xFF39810D).withOpacity(0.2),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Tidak",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close)),
    );
  }
}

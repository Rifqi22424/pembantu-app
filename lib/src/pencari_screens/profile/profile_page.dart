import 'package:flutter/material.dart';
import 'package:prt/main.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/database/shared_preferences.dart';
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
  bool isOverlayIn = false;
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
          : Stack(
              children: [
                ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: SingleChildScrollView(
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
                                // editProfileButton(),
                                SizedBox(height: 26),
                                // SizedBox(height: 76),
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
                                        Navigator.pushNamed(
                                            context, '/transaction');
                                      },
                                    ),
                                    buildListTile(
                                      iconPath: 'images/location.png',
                                      title: 'Alamat',
                                      onTap: () {},
                                    ),
                                    line(),
                                    buildListTile(
                                      iconPath: 'images/key.png',
                                      title: 'Ubah Pin',
                                      onTap: () {},
                                    ),
                                    buildListTile(
                                      iconPath: 'images/questionMark.png',
                                      title: 'Pusat Bantuan',
                                      onTap: () {},
                                    ),
                                    buildListTile(
                                      iconPath: 'images/exclamationMark.png',
                                      title: 'Kebijakan Privasi',
                                      onTap: () {},
                                    ),
                                    buildListTile(
                                      iconPath: 'images/documentSign.png',
                                      title: 'Syarat dan Ketentuan',
                                      onTap: () {},
                                    ),
                                    buildListTile(
                                      iconPath: 'images/logoutSign.png',
                                      title: 'Log Out',
                                      onTap: () {
                                        // setState(() {
                                        //   isOverlayIn = true;
                                        // });
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
                          // approveAcc(),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  child: overlayConfirmLogOut(),
                  visible: isOverlayIn,
                )
              ],
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

  overlayConfirmLogOut() {
    // return Positioned.fill(
    //   child: Align(
    //     alignment: Alignment.center,
    //     child: Center(
    //       child: Container(
    //         width: 300,
    //         height: 300,
    //         clipBehavior: Clip.antiAlias,
    //         decoration: ShapeDecoration(
    //           color: Colors.white,
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(32)),
    //         ),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             SizedBox(height: 20),
    //             Image.asset('images/exclamation.png', width: 70, height: 70),
    //             Text(
    //               'Apakah Anda yakin ingin keluar dari akun?',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 color: Color(0xFFF7D003),
    //                 fontSize: 24,
    //                 fontFamily: 'Asap',
    //                 fontWeight: FontWeight.w600,
    //                 height: 1.3,
    //               ),
    //             ),
    //             SizedBox(height: 5),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 ElevatedButton(
    //                   onPressed: () async {
    //                     await saveTokenToSharedPreferences('deleted');
    //                     Navigator.pushAndRemoveUntil(
    //                       context,
    //                       MaterialPageRoute(builder: (context) => LoginPage()),
    //                       (Route<dynamic> route) => false,
    //                     );
    //                   },
    //                   style: ElevatedButton.styleFrom(
    //                     backgroundColor: Colors.red,
    //                   ),
    //                   child: Text(
    //                     'Ya',
    //                     style: TextStyle(color: Colors.white),
    //                   ),
    //                 ),
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     setState(() {
    //                       isOverlayIn = false;
    //                     });
    //                   },
    //                   style: ElevatedButton.styleFrom(
    //                     backgroundColor: Colors.green,
    //                   ),
    //                   child: Text(
    //                     'Tidak',
    //                     style: TextStyle(color: Colors.white),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Center(
      child: Container(
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
        child: Container(
          padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              titleSchedule(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await saveTokenToSharedPreferences('deleted');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'Ya',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isOverlayIn = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'Tidak',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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

  submitSchedule() {
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
      onPressed: () {},
      child: Text(
        'Schedule',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Text titleSchedule() {
    return Text(
      'Apakah Anda yakin ingin keluar dari akun?',
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 18,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

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
                      // editProfileButton(),
                      // SizedBox(height: 76),
                      ListView(
                        shrinkWrap: true,
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
                            onTap: () async {
                              await saveTokenToSharedPreferences('deleted');
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false,
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

  line() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      child: Divider(
        thickness: 1,
        color: Color(0XFFF2F2F2),
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
      children: [
        // Text(
        //   userProfile!.profile["nama_lengkap"],
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     color: Color(0xFF080C11),
        //     fontSize: 14,
        //     fontFamily: 'Asap',
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        // SizedBox(height: 6),
        Text(
          userProfile!.email,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 14,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
              color: Color.fromARGB(255, 231, 231, 231)),
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

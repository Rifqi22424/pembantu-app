// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prt/main.dart';
import 'package:prt/src/api/auth_model.dart';
import 'package:prt/src/api/fetch_data.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/models/time_interview.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/limit_text.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class DetailProfilePage extends StatefulWidget {
  final UserProfile user;

  const DetailProfilePage({super.key, required this.user});

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  bool isSelengkapnyaPressed = false;

  final UserProvider userProvider = UserProvider();
  bool isInterviewButtonPressed = false;
  bool isCostumButtonPressed = false;
  List<InterviewFree> interviewDates = generateInterviewFreeList();
  int selectedIndex = -1;
  int index = 0;

  String alamat = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final List<String> time = ['9:00', '10:00', '12:00', '20.00'];
  int selectedTimeIndex = -1;

  VideoCall videocall = VideoCall();
  late String? channelName = ''; 
  late String? token = ''; 

  late FetchData fetchData;
  late String authToken;
  late String id;

  @override
  void initState() {
    super.initState();
    authToken = '1|wLQRRxEnI5e4U6LMb6dUn49LJovzoUwKy8rUq9lh66972726';
    id = '1';
    fetchData = FetchData(authToken, id);
    videocall;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: deviceTypeTablet() ? 400 : screenWidth,
          child: Stack(
            children: [
              ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          photoBackground(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              back(context),
                              title(),
                              like(context),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 24, right: 24, top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            nameNType(),
                            SizedBox(height: 16),
                            ratingNInfo(),
                            SizedBox(height: 16),
                            description(),
                            selengkapnyaContent(),
                            isSelengkapnyaPressed
                                ? SizedBox(height: 10)
                                : SizedBox(height: 20),
                            price(),
                            SizedBox(height: 20),
                            messageNInterview(),
                            SizedBox(height: 30),
                            terkaitText(),
                          ],
                        ),
                      ),
                      _buildUserList(),
                    ],
                  ),
                ),
              ),
              if (isInterviewButtonPressed) overlayInterviewSchedule(index),
              if (isCostumButtonPressed) overlayCostumSchedule()
            ],
          ),
        ),
      ),
      floatingActionButton: floatingButton(),
      bottomNavigationBar: botBar(context),
    );
  }

  selengkapnyaContent() {
    List<String> skills = widget.user.profile['skill']
        .map<String>((skill) => skill['name'].toString())
        .toList();

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isSelengkapnyaPressed ? 230 : 0,
      child: IgnorePointer(
        ignoring: true,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  'Tempat Tinggal :',
                  style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 10,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w600,
                    height: 1.67,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.user.profile["alamat_sekarang"],
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 10,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Agama :',
                  style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 10,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w600,
                    height: 1.67,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.user.profile["agama"],
                  style: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 10,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Keahlian :',
                  style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 10,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w600,
                    height: 1.67,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Wrap(
                    spacing: 4,
                    children: skills.map((value) {
                      return Chip(
                        label: Text(value),
                        labelStyle: TextStyle(
                          color: Color(0xFF828993),
                          fontSize: 10,
                          fontFamily: 'Asap',
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text terkaitText() {
    return Text(
      'Terkait',
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 14,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  messageNInterview() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.all(4),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFFECECEC),
                ),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            child: GestureDetector(
              onTap: () async {
                try {
                  final data = await fetchData.createTokenVideocall();
                  setState(() {
                    channelName = data['Name'];
                    token = data['Token'];
                  });
                } catch (e) {
                  print(e);
                }
                Navigator.pushNamed(context, '/videocall', arguments: {
                  'channel': "WfCp7xTmj5Yt5sR4AyVwUeLrCzOpgv",
                  'token': "007eJxTYJCesMVYZZmOv8e0J1uuTj++9JwwP9vr1efzf77l43W24J+owGBoYZJimZRmmmRpbGlilGZgYZxqmWJuaZZqam6UamCeLG5nlirAx8Bw9M9hBkYgZAFiEJ8JTDKDSRYwKccQnuZcYF4RkptlGlliWhxk4lgZVh6a6lPkXOVfkF7GyGAAAJgbJwY=",
                });
              },
              child: Center(
                child: Image.asset(
                  'images/InterviewGreen.png',
                ),
              ),
            ),
          ),
          interviewButton(),
        ],
      ),
    );
  }

  price() {
    return Row(
      children: [
        Text(
          'Rp. ',
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 16,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          widget.user.profile["gaji"].toString(),
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 16,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  description() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: widget.user.profile["deskripsi"],
            style: TextStyle(
              color: Color(0xFF828993),
              fontSize: 10,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
              height: 1.67,
            ),
          ),
          isSelengkapnyaPressed
              ? TextSpan()
              : TextSpan(
                  text: " Selengkapnya",
                  style: TextStyle(
                    color: Color(0xFF38800C),
                    fontSize: 10,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w700,
                    height: 1.67,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isSelengkapnyaPressed = true;
                      });
                    },
                ),
        ],
      ),
    );
  }

  void _toggleUserLikedStatus(UserProfile user) {
    final newIsLiked = !user.isLiked;
    final userProvider = UserProvider(); // Create an instance
    userProvider.updateUserLikedStatus(
        user.profile["id"], newIsLiked); // Call the method on the instance
  }

  Widget _buildUserList() {
    return FutureBuilder<List<UserProfile?>>(
      future: fetchUserProfiles(), // Panggil fungsi fetchUserProfiles
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Terjadi kesalahan: ${snapshot.error}');
        } else {
          final userProfiles = snapshot.data ?? [];

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 6),
            itemCount: userProfiles.length,
            itemBuilder: (context, index) {
              final user = userProfiles[index];
              if (user == widget.user) {
                return Container();
              } else {
                return _buildUserListItem(user!);
              }
            },
          );
        }
      },
    );
  }

  _buildUserListItem(UserProfile user) {
    final Color loveColor = user.isLiked ? Color(0xFFFF0E0E) : Colors.white;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detailprofile', arguments: user);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                          "$serverPath${user.profile["foto_setengah_badan"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _toggleUserLikedStatus(user);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4, top: 4),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                              color: Colors.black.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              )),
                          child: Image.asset(
                            'images/WhiteLove.png',
                            width: 15,
                            height: 15,
                            color: loveColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFB84E),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                        ),
                        child: Stack(
                          children: [
                            Text(
                              user.category["name"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontFamily: 'Asap',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        user.profile["nama_lengkap"],
                        style: TextStyle(
                          color: Color(0xFF080C11),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'images/Star.png',
                                  width: 11,
                                  height: 11,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  user.profile["rating"],
                                  style: TextStyle(
                                    color: Color(0xFF080C11),
                                    fontSize: 8,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/PeopleIcon.png',
                                  width: 14,
                                  height: 14,
                                ),
                                Text(
                                  user.profile["usia"],
                                  style: TextStyle(
                                    color: Color(0xFF080C11),
                                    fontSize: 8,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/TimeIcon.png',
                                  width: 9,
                                  height: 9,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  user.profile["lama_pengalaman_bekerja"],
                                  style: TextStyle(
                                    color: Color(0xFF080C11),
                                    fontSize: 8,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          limitText(user.profile["deskripsi"], 45),
                          style: TextStyle(
                            color: Color(0xFF828993),
                            fontSize: 8,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 0.1),
                      Text(
                        'Rp. ${user.profile["gaji"]}',
                        style: TextStyle(
                          color: Color(0xFF080C11),
                          fontSize: 11,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            thickness: 2,
            color: Color(0xFFF5F5F5),
          ),
        ),
      ],
    );
  }

  floatingButton() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      onPressed: () {},
      child: Image.asset(
        'images/Phone.png',
        height: 24,
        width: 24,
      ),
    );
  }

  botBar(BuildContext context) {
    return BottomAppBar(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Image.asset('images/Home.png')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/transaction');
              },
              icon: Image.asset('images/Dolar.png')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/listchat');
              },
              icon: Image.asset('images/Message.png')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: Image.asset('images/User.png')),
        ],
      ),
    );
  }

  interviewButton() {
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
        setState(() {
          isInterviewButtonPressed = true;
        });
      },
      child: Text(
        'Interview',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container ratingNInfo() {
    // ignore: sized_box_for_whitespace
    return Container(
      width: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'images/Star.png',
                width: 14,
                height: 14,
              ),
              SizedBox(width: 4),
              Text(
                widget.user.profile["rating"],
                style: TextStyle(
                  color: Color(0xFF080C11),
                  fontSize: 10,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          Row(
            children: [
              Image.asset(
                'images/PeopleIcon.png',
                width: 18,
                height: 18,
              ),
              SizedBox(width: 2),
              Text(
                '${widget.user.profile["usia"]} thn',
                style: TextStyle(
                  color: Color(0xFF080C11),
                  fontSize: 10,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          Row(
            children: [
              Image.asset(
                'images/TimeIcon.png',
                width: 13,
                height: 13,
              ),
              SizedBox(width: 4),
              Text(
                '${widget.user.profile["lama_pengalaman_bekerja"]} thn',
                style: TextStyle(
                  color: Color(0xFF080C11),
                  fontSize: 10,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  nameNType() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.user.profile["nama_lengkap"],
            style: TextStyle(
              color: Color(0xFF080C11),
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: ShapeDecoration(
              color: Color(0xFFFFB84E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
            ),
            child: Stack(
              children: [
                Text(
                  widget.user.category["name"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  photoBackground() {
    return SizedBox(
      height: 355,
      width: double.maxFinite,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        child: Image.network(
          "$serverPath${widget.user.profile["foto_setengah_badan"]}",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  back(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 60),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 30,
            height: 30,
            padding: EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Image.asset('images/NavBackTransparant.png'),
          ),
        ),
      ),
    );
  }

  title() {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          'Detail Profile',
          textAlign: TextAlign.center,
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

  like(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 24),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 30,
            height: 30,
            padding: EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: Image.asset(
              'images/WhiteLove.png',
              width: 10,
              height: 10,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  overlayInterviewSchedule(index) {
    return Center(
      child: Container(
        width: 350,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                deleteButton(),
                SizedBox(height: 22),
                titleSchedule(),
                SizedBox(height: 10),
                descSchedule(),
                SizedBox(height: 14),
                dateText(),
                SizedBox(height: 14),
                listDates(),
                SizedBox(height: 14),
                timeText(),
                SizedBox(height: 10),
                listTimes(index),
                SizedBox(height: 22),
                submitSchedule(),
                SizedBox(height: 14),
                submitCostum(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  deleteButton() {
    return Align(
        alignment: Alignment.topRight,
        child: Image.asset('images/xNoBG.png', width: 16, height: 16));
  }

  submitCostum() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        minimumSize:
            MaterialStateProperty.all<Size>(Size(double.maxFinite, 44)),
      ),
      onPressed: () {
        setState(() {
          isInterviewButtonPressed = false;
          isCostumButtonPressed = true;
        });
      },
      child: Text(
        'Custom Schedule',
        style: TextStyle(
          color: Color(0xFF38800C),
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  submitSchedule() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize:
            MaterialStateProperty.all<Size>(Size(double.maxFinite, 44)),
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

  listTimes(index) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: time.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTimeIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: ShapeDecoration(
                color: selectedTimeIndex == index
                    ? Color(0x1939810D)
                    : Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                time[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedTimeIndex == index
                      ? Color(0xFF38800C)
                      : Color(0xFF080C11),
                  fontSize: 14,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Text timeText() {
    return Text(
      'Time',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 16,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  listDates() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: interviewDates.length,
        itemBuilder: (context, index) {
          final interviewDate = interviewDates[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: IntrinsicHeight(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: ShapeDecoration(
                  color: index == selectedIndex
                      ? Color(0x1939810D)
                      : Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        '${interviewDate.day}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: index == selectedIndex
                              ? Color(0xFF38800C)
                              : Color(0xFF080C11),
                          fontSize: 16,
                          fontFamily: 'Asap',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      interviewDate.month,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: index == selectedIndex
                            ? Color(0xFF38800C)
                            : Color(0xFF828993),
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
        },
      ),
    );
  }

  Text dateText() {
    return Text(
      'Date',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 16,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text descSchedule() {
    return Text(
      'We hope that the interview will run smoothly and there will be no problems',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF828993),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.71,
      ),
    );
  }

  Text titleSchedule() {
    return Text(
      'Interview Schedule',
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 18,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  overlayCostumSchedule() {
    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(24),
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                deleteLayout(),
                SizedBox(height: 20),
                titileCostumSchedule(),
                SizedBox(height: 12),
                descText(),
                SizedBox(height: 32),
                _alamat(),
                SizedBox(height: 16),
                _timePickerButton(),
                SizedBox(height: 16),
                _datePickerButton(),
                SizedBox(height: 32),
                Expanded(
                  child: submitScheduleCostum(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align deleteLayout() {
    return Align(
      alignment: Alignment.topRight,
      child: Image.asset('images/xNoBG.png', width: 16, height: 16),
    );
  }

  Text titileCostumSchedule() {
    return Text(
      'Interview Schedule',
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 18,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text descText() {
    return Text(
      'We hope that the interview will run smoothly and there will be no problems',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF828993),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.71,
      ),
    );
  }

  submitScheduleCostum() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize:
            MaterialStateProperty.all<Size>(Size(double.maxFinite, 80)),
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

  _alamat() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Master schedule name',
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          hintStyle: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        onSaved: (String? value) {
          alamat = value!;
        },
      ),
    );
  }

  Widget _datePickerButton() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextButton(
        onPressed: () {
          _selectDate(context);
        },
        child: Text(
          selectedDate == null
              ? 'mm/dd/yy'
              : 'Schedule: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _timePickerButton() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextButton(
        onPressed: () {
          _selectTime(context);
        },
        child: Text(
          selectedTime == null
              ? '--:--'
              : 'Waktu: ${selectedTime!.hour}:${selectedTime!.minute}',
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
      ),
    );
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
}

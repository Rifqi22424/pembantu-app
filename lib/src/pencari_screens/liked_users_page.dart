// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/widgets/limit_text.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

import '../../main.dart';
import '../api/like_api.dart';
import '../widgets/loading_user_list.dart';

class LikedUsersPage extends StatefulWidget {
  final List<UserProfile> userList;
  const LikedUsersPage({super.key, required this.userList});

  @override
  State<LikedUsersPage> createState() => _LikedUsersPageState();
}

class _LikedUsersPageState extends State<LikedUsersPage> {
  Future<List<UserProfile>> _userlikeProfileFuture = fetchLikedProfile();
  LikeApi likeApi = LikeApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _likedText(),
              _buildUserList(),
            ],
          ),
        ),
      ),
    );
  }

  back(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Row(
        children: [
          GestureDetector(
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
        ],
      ),
    );
  }

  void _toggleUserLikedStatus(UserProfile user) {
    user.isLiked = !user.isLiked;
    try {
      likeApi.likeUser(user.id);
    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  Widget _buildUserList() {
    return FutureBuilder<List<UserProfile>>(
      future: _userlikeProfileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingData();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          final usersFromAPI = snapshot.data;
          if (usersFromAPI == null || usersFromAPI.isEmpty) {
            return dataIsEmpty();
          }
          List<UserProfile> users = usersFromAPI;

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 6),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return _buildUserListItem(user);
            },
          );
        }
      },
    );
  }

  dataIsEmpty() {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Text("Tidak ada data"),
      ],
    );
  }

  loadingData() {
    return SizedBox(
      width: 400,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 6),
        itemCount: 6,
        itemBuilder: (context, index) {
          return loadingUserList();
        },
      ),
    );
  }

  String rattingNull(UserProfile user) {
    if (user.profile["rating"] == null) {
      return "0";
    } else {
      return user.profile["rating"].toString();
    }
  }

  _buildUserListItem(UserProfile user) {
    final Color loveColor = user.isLiked ? Color(0xFFFF0E0E) : Colors.white;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detailprofile', arguments: user.id);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                listImages(user, loveColor),
                SizedBox(width: 16),
                SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      userType(user),
                      userName(user),
                      userRating(user),
                      userDesc(user),
                      userPrice(user)
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

  Padding userPrice(UserProfile user) {
    final gaji = user.profile["gaji"];
    final formattedGaji = NumberFormat.decimalPattern('vi_VN').format(gaji);

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        'Rp. $formattedGaji',
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 11,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  SizedBox userDesc(UserProfile user) {
    return SizedBox(
      width: 150,
      child: Text(
        limitText(user.profile["deskripsi"], 60),
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 8,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  SizedBox userRating(UserProfile user) {
    return SizedBox(
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
                rattingNull(user),
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
    );
  }

  Text userName(UserProfile user) {
    return Text(
      user.profile["nama_lengkap"],
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Container userType(UserProfile user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: ShapeDecoration(
        color: Color(0xFFFFB84E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
    );
  }

  Container listImages(UserProfile user, Color loveColor) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image:
              NetworkImage("$serverPath${user.profile["foto_setengah_badan"]}"),
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
    );
  }

  _likedText() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, bottom: 20),
      child: Stack(
        children: [
          back(context),
          Center(
            child: Text(
              'Liked',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prt/src/models/user_model.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'package:prt/src/widgets/limit_text.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class LikedUsersPage extends StatefulWidget {
  final List<User> userList;
  const LikedUsersPage({super.key, required this.userList});

  @override
  State<LikedUsersPage> createState() => _LikedUsersPageState();
}

class _LikedUsersPageState extends State<LikedUsersPage> {
  final UserProvider userProvider = UserProvider();
  List<User> likedUsers = [];

  @override
  void initState() {
    super.initState();
    likedUsers = widget.userList.where((user) => user.isLiked).toList();
  }

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

  void _toggleUserLikedStatus(User user) {
    final newIsLiked = !user.isLiked;
    userProvider.updateUserLikedStatus(user.id, newIsLiked);
  }

  Widget _buildUserList() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final likedUsers =
            userProvider.users.where((user) => user.isLiked).toList();
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 6),
          itemCount: likedUsers.length,
          itemBuilder: (context, index) {
            final user = likedUsers[index];
            return _buildUserListItem(user);
          },
        );
      },
    );
  }

  _buildUserListItem(User user) {
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
                      image: AssetImage(user.imageUrl),
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
                              user.type,
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
                        user.name,
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
                                  user.star,
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
                                  '${user.age}',
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
                                  '${user.experience}',
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
                          limitText(user.description, 60),
                          style: TextStyle(
                            color: Color(0xFF828993),
                            fontSize: 8,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          'Rp. ${user.price}',
                          style: TextStyle(
                            color: Color(0xFF080C11),
                            fontSize: 11,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
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

  _likedText() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Center(
        child: Text(
          'Liked',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

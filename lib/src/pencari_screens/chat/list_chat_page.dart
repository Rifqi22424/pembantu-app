// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/models/chat_user_model.dart';
import 'package:prt/src/models/chat_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/limit_text.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class ListChatPage extends StatefulWidget {
  const ListChatPage({super.key});

  @override
  State<ListChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ListChatPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String searchText = '';
  bool maintenance = false;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: maintenance
          ? maintananceWidget()
          : Center(
              child: SizedBox(
                width: deviceTypeTablet() ? 400 : screenWidth,
                child: Column(
                  children: [
                    SizedBox(height: 55),
                    pesanText(),
                    search(),
                    isSearching ? Container() : favoritesChat(),
                    isSearching ? Container() : allMessage(),
                    listChat(),
                  ],
                ),
              ),
            ),
    );
  }

  maintananceWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Under Maintenance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(
            color: Color(0xFF38800C),
          ),
        ],
      ),
    );
  }

  Text pesanText() {
    return Text(
      'Pesan',
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  listChat() {
    final List<Chat> displayChats = isSearching
        ? chats
            .where((chat) => chat.sender.name
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList()
        : chats;

    return Expanded(
      child: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: displayChats.length,
          itemBuilder: (context, index) {
            final chat = displayChats[index];
            return Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 2),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/chat',
                      arguments: {'user': chat, 'isRealUser': false});
                },
                child: Material(
                  // color: Colors.white,
                  child: SizedBox(
                    width: 200,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFE7E7E7),
                          radius: 28,
                          backgroundImage: AssetImage(chat.imageUrl),
                        ),
                        SizedBox(width: 12),
                        SizedBox(
                          width: 210,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat.sender.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Asap',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                limitText(chat.lastMessage, 32),
                                style: TextStyle(
                                  color: Color(0xFF828993),
                                  fontSize: 10,
                                  fontFamily: 'Asap',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 80,
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                chats[index].time,
                                style: TextStyle(
                                  color: Color(0xFFB8BEC8),
                                  fontSize: 10,
                                  fontFamily: 'Asap',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 14),
                              if (chat.unRead == '')
                                Container(
                                  width: 14,
                                  height: 14,
                                  color: Colors.white,
                                )
                              else
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF38800C),
                                      shape: OvalBorder(),
                                    ),
                                    child: Center(
                                      child: Text(
                                        chat.unRead,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontFamily: 'Asap',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding allMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'All Message',
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Container favoritesChat() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 100,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 14),
        scrollDirection: Axis.horizontal,
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, '/chat', arguments: chats[index]);
              Navigator.pushNamed(context, '/chat',
                  arguments: {'user': chats[index], 'isRealUser': false});
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 14.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFE7E7E7),
                    radius: 28,
                    backgroundImage: AssetImage(favorites[index].imageUrl),
                  ),
                  SizedBox(height: 6),
                  Text(
                    limitText(favorites[index].name, 5),
                    style: TextStyle(
                      color: Color(0xFF828993),
                      fontSize: 10,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding search() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: SizedBox(
        width: 400,
        height: 50,
        child: Container(
          width: 280,
          height: 54,
          decoration: ShapeDecoration(
            color: Color(0xFFF5F5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: TextField(
            onChanged: (text) {
              setState(() {
                searchText = text;
                isSearching = text.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search...',
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
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'images/search.png',
                  width: 20,
                  height: 20,
                ),
                splashColor: Colors.transparent,
              ),
            ),
            style: TextStyle(
              color: Color(0xFF828993),
              fontSize: 12,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
              height: 1.7,
            ),
          ),
        ),
      ),
    );
  }

  botBar() {
    return BottomAppBar(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Image.asset('images/HomePlain.png')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/transaction');
              },
              icon: Image.asset('images/Dolar.png')),
          IconButton(
              onPressed: () {}, icon: Image.asset('images/MessageGreen.png')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: Image.asset('images/User.png')),
        ],
      ),
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
}

// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/models/chat_user_model.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';
// import 'package:prt/src/models/chat_user_model.dart';
import '../../models/chat_model.dart';

class ChatPage extends StatefulWidget {
  final Chat user;

  ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  int maxLines = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          messages(),
          botBar(),
        ], 
      ),
    );
  }

  botBar() {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxWidth: 100),
              padding: EdgeInsets.only(left: 20),
              // width: 200,
              // height: 50,
              child: TextField(
                controller: _textController,
                maxLines: null,
                onChanged: (text) {
                  int lines = _textController.text.split('\n').length;
                  if (lines > maxLines && lines <= 4) {
                    setState(() {
                      maxLines = lines;
                    });
                  } else if (lines <= maxLines) {
                    setState(() {
                      maxLines = lines;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Ketik Pesan...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color(0xFF828993),
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    height: 1.71,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'images/rantai.png',
                width: 20,
                height: 20,
              )),
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            // padding: EdgeInsets.all(),
            decoration: ShapeDecoration(
                color: Color(0xFF439610),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(41))),
            child: IconButton(
                onPressed: () {}, icon: Image.asset('images/sent.png')),
          ),
        ],
      ),
    );
  }

  messages() {
    return ScrollConfiguration(
      behavior: NoGlowBehavior(),
      child: Expanded(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 12, right: 12, left: 12),
          scrollDirection: Axis.vertical,
          itemCount: newChats.length,
          itemBuilder: (context, index) {
            final message = newChats[index];
            final bool isMe = message.sender.id == currentUser.id;
            return _buildMessageWidget(message, isMe);
          },
        ),
      ),
    );
  }

  appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(top: 5, left: 10, bottom: 5),
          child: IconButton(
            icon: Image.asset(
              'images/NavBackGreen.png',
              height: 30,
              width: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/AppBarChatBG.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFE7E7E7),
              radius: 20,
              backgroundImage: AssetImage(widget.user.imageUrl),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.sender.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.user.time,
                  style: TextStyle(
                    color: Color(0xFFEFEFEF),
                    fontSize: 8,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/videocall');
                },
                icon: Image.asset('images/InterviewGreen.png')),
          )
        ],
      ),
    );
  }

  _buildMessageWidget(Chat message, bool isMe) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: isMe
                  ? ShapeDecoration(
                      color: Color(0xFF439610),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      )))
                  : ShapeDecoration(
                      color: Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 250),
                    child: Text(
                      message.lastMessage,
                      style: isMe
                          ? TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.w400,
                              height: 1.71,
                            )
                          : TextStyle(
                              color: Color(0xFF828993),
                              fontSize: 12,
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.w400,
                              height: 1.71,
                            ),
                    ),
                  ),
                  SizedBox(width: 2),
                  Text(
                    message.time,
                    style: TextStyle(
                      color: Color(0xFFB8BEC8),
                      fontSize: 10,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

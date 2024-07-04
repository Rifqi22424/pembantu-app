// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/models/chat_user_model.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';
import '../../../main.dart';
import '../../api/fetch_data.dart';
import '../../api/push_notif.dart';
import '../../models/chat_model.dart';
import '../../models/message_model.dart';

class ChatPage extends StatefulWidget {
  final Chat? user;
  final bool isRealUser;
  final UserProfile? profile;

  ChatPage({super.key, this.user, this.profile, required this.isRealUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  int maxLines = 1;
  List<Message> _messages = [];
  late String? channelName = '';
  late String? token = '';
  late FetchData fetchData;

  @override
  void initState() {
    super.initState();
    _initializeDemoMessages();
  }

  void _initializeDemoMessages() {
    _messages = [
      Message(sender: currentUser, text: 'Hello!', time: '10:00 AM'),
      Message(sender: widget.user!.sender, text: 'Hi there!', time: '10:01 AM'),
      Message(sender: currentUser, text: 'How are you?', time: '10:02 AM'),
      Message(sender: widget.user!.sender, text: 'I am good, thanks! How about you?', time: '10:03 AM'),
      Message(sender: currentUser, text: 'I\'m doing well, thank you!', time: '10:04 AM'),
      Message(sender: widget.user!.sender, text: 'That\'s great to hear!', time: '10:05 AM'),
      Message(sender: currentUser, text: 'What have you been up to?', time: '10:06 AM'),
      Message(sender: widget.user!.sender, text: 'Just working on some projects. You?', time: '10:07 AM'),
      Message(sender: currentUser, text: 'Same here, keeping busy with work.', time: '10:08 AM'),
      Message(sender: widget.user!.sender, text: 'Got any plans for the weekend?', time: '10:09 AM'),
      Message(sender: currentUser, text: 'Not yet, maybe just relaxing. You?', time: '10:10 AM'),
      Message(sender: widget.user!.sender, text: 'Might go hiking if the weather is nice.', time: '10:11 AM'),
      Message(sender: currentUser, text: 'Sounds fun! Where do you usually hike?', time: '10:12 AM'),
      Message(sender: widget.user!.sender, text: 'There\'s a great trail near the mountains.', time: '10:13 AM'),
      Message(sender: currentUser, text: 'I love hiking in the mountains!', time: '10:14 AM'),
      Message(sender: widget.user!.sender, text: 'Me too! It\'s so peaceful there.', time: '10:15 AM'),
      Message(sender: currentUser, text: 'Absolutely. Nature is the best escape.', time: '10:16 AM'),
      Message(sender: widget.user!.sender, text: 'Indeed. Maybe we could hike together sometime.', time: '10:17 AM'),
      Message(sender: currentUser, text: 'That would be awesome! Let\'s plan it.', time: '10:18 AM'),
    ];
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    Message message =
        Message(sender: currentUser, text: text, time: '12:00 AM');
    setState(() {
      _messages.add(message);
    });

    Future.delayed(Duration(seconds: 1), () {
      Message reply = Message(
          sender: widget.user!.sender,
          text: 'Hallo, senang bisa bersapa dengan anda',
          time: '13:00 AM');
      setState(() {
        _messages.add(reply);
      });
    });
  }

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
                onPressed: () {
                  if (_textController.text != '') {
                    _handleSubmitted(_textController.text);
                  }
                },
                icon: Image.asset('images/sent.png')),
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
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            final message = _messages[index];
            final bool isMe = message.sender.id == currentUser.id;
            return _buildMessageWidget(message, isMe);
          },
        ),
      ),
    );
  }

  ImageProvider<Object> image(bool isReal) {
    if (isReal) {
      return NetworkImage(
          "$serverPath${widget.profile!.profile["foto_setengah_badan"]}");
    } else {
      return AssetImage(widget.user!.imageUrl);
    }
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

              // backgroundImage: widget.isRealUser == true
              //     ? NetworkImage("$serverPath${widget.profile!.profile["foto_setengah_badan"]}")
              //     : AssetImage(widget.user!.imageUrl),
              // widget.isRealUser == true
              //     ? backgroundImage
              //     : NetworkImage(
              //         "$serverPath${widget.profile!.profile["foto_setengah_badan"]}"),
              backgroundImage: image(widget.isRealUser),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isRealUser
                      ? widget.profile!.profile["nama_lengkap"]
                      : widget.user!.sender.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.user!.time,
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
                onPressed: () async {
                  // Navigator.pushNamed(context, '/videocall');
                  try {
                    final data = await fetchData.createTokenVideocall();
                    setState(() {
                      channelName = data['Name'];
                      token = data['Token'];
                    });
                  } catch (e) {
                    print(e);
                    _showTopSnackbar(context, "Gagal Membuka Interview", false);
                  }
                  try {
                    bool sendNotif = await FirebaseNotifAPI().sendNotification(
                        widget.profile!.devicetoken,
                        "User",
                        channelName!,
                        token!);
                    if (sendNotif) {
                      print('Notif telah dikirim');
                      Navigator.pushNamed(context, '/videocall', arguments: {
                        'channel': channelName,
                        'token': token,
                      });
                    }
                  } catch (e) {
                    print('Notif gagal dikirim');
                    _showTopSnackbar(context, "Gagal Membuka Interview", false);
                  }
                },
                icon: Image.asset('images/InterviewGreen.png')),
          )
        ],
      ),
    );
  }

  _buildMessageWidget(Message message, bool isMe) {
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
                      message.text,
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

  void _showTopSnackbar(BuildContext context, String label, bool isTrueColor) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: isTrueColor ? Color(0xFF39810D) : Color(0xFFFF2222),
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    label,
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

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

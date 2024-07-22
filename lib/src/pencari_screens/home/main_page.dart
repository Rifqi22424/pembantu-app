import 'package:flutter/material.dart';
import 'package:prt/src/models/chat_user_model.dart';
import 'package:prt/src/pencari_screens/chat/list_chat_page.dart';
import 'package:prt/src/pencari_screens/home/home_page.dart';
import 'package:prt/src/pencari_screens/profile/profile_page.dart';
import 'package:prt/src/pencari_screens/transaction_page.dart';

import '../../models/chat_model.dart';

class MainPage extends StatefulWidget {
  final int index;
  const MainPage({required this.index, super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  final List<Widget> _pages = [
    HomePage(),
    TransactionPage(),
    ListChatPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
      floatingActionButton: whenfloatingButton(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        if (index == 3) {
          Navigator.pushNamed(context, '/profile');
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(0, 'images/HomePlain.png', 'Home'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(1, 'images/Dolar.png', 'Transaksi'),
          label: 'Transaksi',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(2, 'images/Message.png', 'Pesan'),
          label: 'Pesan',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(3, 'images/User.png', 'Profile'),
          label: 'Profile',
        ),
      ],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Color(0xFF828993),
      selectedItemColor: Colors.green,
      selectedLabelStyle: const TextStyle(
        color: Colors.green,
        fontSize: 10,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Color(0xFF828993),
        fontSize: 10,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildIcon(int index, String image, String name) {
    return _currentIndex == index
        ? ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.green,
              BlendMode.modulate,
            ),
            child: Image.asset(
              image,
              width: 28,
              height: 28,
            ),
          )
        : Image.asset(
            image,
            width: 28,
            height: 28,
          );
  }

  whenfloatingButton() {
    if (_currentIndex == 0 || _currentIndex == 2) {
      return floatingButton();
    }
  }

  Widget floatingButton() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      onPressed: () {
        // Navigator.pushNamed(context, '/homepekerja');

        Navigator.pushNamed(context, '/chat', arguments: {
          'user': Chat(
            imageUrl: 'images/Phone.png',
            sender: admin,
            lastMessage: 'Hello, how are you?',
            time: '10:30 AM',
            unRead: '2',
          ),
          'isRealUser': false
        });
      },
      child: Image.asset(
        'images/Phone.png',
        height: 24,
        width: 24,
      ),
    );
  }
}

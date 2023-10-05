// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'package:prt/src/models/user_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/limit_text.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserProvider userProvider = UserProvider();
  String search = '';
  bool isAmountVisible = true;
  int selectedIndex = -1;
  final List<String> types = ['ART', 'Supir', 'Satpam', 'Baby Sister', 'PRT'];
  String? selectedCategory;
  bool tabletDevice = deviceTypeTablet();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: deviceTypeTablet() ? 400 : screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mangCodingTextNRow(context),
                  filterNSearch(context),
                  saldoContent(),
                  categoryNText(),
                  selectCategory(),
                  buildUserList(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: botBar(context),
      floatingActionButton: floatingButton(),
    );
  }

  Padding mangCodingTextNRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, top: 45, right: 22),
      child: SizedBox(
        width: 400,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selamatdatangText(),
                mangcodingText(),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/likedusers',
                    arguments: userList);
              },
              child: Row(
                children: [
                  likedPageButton(),
                  SizedBox(
                    width: 10,
                  ),
                  notifPageButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector notifPageButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/notif');
      },
      child: Container(
        width: 34,
        height: 34,
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
        child: Center(
          child: Stack(
            children: [
              Image.asset(
                'images/Bell.png',
                width: 22,
                height: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container likedPageButton() {
    return Container(
      width: 34,
      height: 34,
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
      child: Center(
        child: Stack(
          children: [
            Image.asset(
              'images/Love.png',
              width: 16,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  categoryNText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: 340,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            categoryText(),
            lihatSemuaButton(),
          ],
        ),
      ),
    );
  }

  Padding saldoContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: IntrinsicHeight(
        child: Container(
          width: 360,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          child: Stack(
            children: [
              backgroundImagesSaldo(),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 18, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    saldoText(),
                    ownSaldo(),
                    cashFlowButton(),
                    line(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        topUpButton(),
                        SizedBox(width: 10),
                        transferButton(),
                        SizedBox(width: 10),
                        tarikTunaiButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding filterNSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, top: 20, right: 22),
      child: SizedBox(
        width: 400,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: searchBox(context),
            ),
            filterButton(),
          ],
        ),
      ),
    );
  }

  GestureDetector lihatSemuaButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = null;
          selectedIndex = -1;
        });
      },
      child: Text(
        'Lihat semua',
        style: TextStyle(
          color: Color(0xFF828993),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Text categoryText() {
    return Text(
      'Category',
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 14,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Image backgroundImagesSaldo() {
    return Image.asset(
      'images/SaldoBg.png',
      width: 360,
      height: 180,
      fit: BoxFit.fill,
    );
  }

  filterButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/search');
      },
      child: Container(
        width: 55,
        height: 55,
        padding: EdgeInsets.all(15),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.5,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFECECEC),
          ),
          borderRadius: BorderRadius.circular(16),
        )),
        child: Stack(
          children: [
            Image.asset(
              'images/filter.png',
              width: 28,
              height: 28,
            ),
          ],
        ),
      ),
    );
  }

  Container searchBox(BuildContext context) {
    return Container(
      height: 54,
      margin: EdgeInsets.only(right: 16),
      decoration: ShapeDecoration(
        color: Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: TextField(
        readOnly: true,
        onTap: () {
          Navigator.pushNamed(context, '/search');
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
    );
  }

  Text mangcodingText() {
    return Text(
      'Mangcoding',
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 18,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text selamatdatangText() {
    return Text(
      'Selamat Datang',
      style: TextStyle(
        color: Color(0xFF828993),
        fontSize: 8,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
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

  botBar(BuildContext context) {
    return BottomAppBar(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () {}, icon: Image.asset('images/Home.png')),
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

  void _toggleUserLikedStatus(User user) {
    final newIsLiked = !user.isLiked;
    userProvider.updateUserLikedStatus(user.id, newIsLiked);
  }

  buildUserList() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final filteredUsers = selectedCategory != null
            ? userProvider.users
                .where((user) => user.type == selectedCategory)
                .toList()
            : userProvider.users;
        return SizedBox(
          width: 400,
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 6),
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return buildUserListItem(user);
            },
          ),
        );
      },
    );
  }

  buildUserListItem(User user) {
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
                  width: 150,
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
                        width: 150,
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
                                SizedBox(width: 4),
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
                                SizedBox(width: 2),
                                Text(
                                  '${user.age} thn',
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
                                SizedBox(width: 3),
                                Text(
                                  '${user.experience} thn',
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

  selectCategory() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SizedBox(
          height: 35,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: types.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    selectedCategory = types[index];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    decoration: ShapeDecoration(
                      color: index == selectedIndex
                          ? Color(0x1939810D)
                          : Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      types[index],
                      style: TextStyle(
                        color: index == selectedIndex
                            ? Color(0xFF38800C)
                            : Color(0xFF828993),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Row ownSaldo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Rp. ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
          child: Text(
            isAmountVisible ? '10.000.000' : '-',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                isAmountVisible = !isAmountVisible;
              });
            },
            icon: Icon(
              isAmountVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
              size: 20,
            ))
      ],
    );
  }

  Text saldoText() {
    return Text(
      'Saldo Anda',
      style: TextStyle(
        color: Color(0xFFEFEFEF),
        fontSize: 10,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  cashFlowButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/cashflow');
      },
      child: Row(
        children: [
          Text(
            'Riwayat pengeluaran',
            style: TextStyle(
              color: Color(0xFFEFEFEF),
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Image.asset(
              'images/NavigateNext.png',
              width: 21,
              height: 21,
            ),
          ),
        ],
      ),
    );
  }

  Divider line() {
    return Divider(
      color: Colors.white,
    );
  }

  Flexible tarikTunaiButton() {
    return Flexible(
      flex: 0,
      fit: FlexFit.tight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.5,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(20),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Add.png',
              width: 12,
              height: 12,
            ),
            SizedBox(width: 6),
            Text(
              'Tarik Tunai',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible transferButton() {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/transfer');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/Add.png',
                width: 12,
                height: 12,
              ),
              SizedBox(width: 6),
              Text(
                'Tranfer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
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

  Flexible topUpButton() {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/topup');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              )),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/Add.png',
                width: 12,
                height: 12,
              ),
              SizedBox(width: 6),
              Text(
                'Top Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
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

  double measureTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width;
  }

  double measureTextWidthNew(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width;
  }
}

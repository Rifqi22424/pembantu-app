// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prt/main.dart';
import 'package:prt/src/api/digital_money.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/api/like_api.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/limit_text.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';
import '../../widgets/loading_user_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final UserProvider userProvider = UserProvider();
  String search = '';
  bool isAmountVisible = true;
  int selectedIndex = -1;
  final List<String> types = ['ART', 'Supir', 'Satpam', 'Baby Sitter', 'PRT'];
  String? selectedCategory;
  bool tabletDevice = deviceTypeTablet();
  Future<List<UserProfile>> _userProfileFuture = filterUserProfiles('all');
  LikeApi likeApi = LikeApi();
  String filter = 'all';
  int? saldoFuture;

  @override
  void initState() {
    super.initState();
    fetchOwnSaldo().then((saldo) {
      setState(() {
        saldoFuture = saldo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        color: Color(0xFF39810D),
        child: ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(
              child: SizedBox(
                width: deviceTypeTablet() ? 600 : screenWidth,
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
      ),
    );
  }

  Padding mangCodingTextNRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 45, right: 16),
      child: SizedBox(
        width: 600,
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
            Row(
              children: [
                schedulesButton(),
                SizedBox(width: 10),
                likedPageButton(),
                SizedBox(width: 10),
                notifPageButton(context),
              ],
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

  schedulesButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/schedules');
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
                'images/interviewTransparant.png',
                color: Color(0xff828993),
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  likedPageButton() {
    return GestureDetector(
      onTap: () {
        final userList = userProvider.users;

        Navigator.pushNamed(context, '/likedusers', arguments: userList);
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
                'images/Love.png',
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  categoryNText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      child: SizedBox(
        width: 440,
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
      padding: const EdgeInsets.only(top: 22, left: 16, right: 16),
      child: IntrinsicHeight(
        child: Container(
          width: 460,
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
      padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
      child: SizedBox(
        width: 600,
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

  lihatSemuaButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = null;
          selectedIndex = -1;
          _userProfileFuture = filterUserProfiles('all');
        });
      },
      child: Text(
        'Lihat semua',
        style: TextStyle(
          color: selectedIndex != -1 ? Color(0xFF828993) : Color(0xFF439610),
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
      width: 460,
      height: 200,
      fit: BoxFit.fill,
    );
  }

  filterButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/search', arguments: false);
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
          Navigator.pushNamed(context, '/search', arguments: true);
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

  void _toggleUserLikedStatus(UserProfile user) async {
    user.isLiked = !user.isLiked;
    try {
      likeApi.likeUser(user.id);
    } catch (e) {
      print(e);
    }

    setState(() {});
  }

  buildUserList() {
    return FutureBuilder<List<UserProfile>>(
      future: _userProfileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingData();
        } else if (snapshot.hasError) {
          return errorUI('Tidak ada data');
        } else {
          final usersFromAPI = snapshot.data;
          if (usersFromAPI == null || usersFromAPI.isEmpty) {
            return errorUI('Tidak ada data');
          }

          List<UserProfile> filteredUsers = [];
          print(selectedCategory);

          if (selectedCategory == null) {
            filteredUsers = usersFromAPI;
          } else {
            filteredUsers = usersFromAPI.toList();
          }

          if (filteredUsers.isEmpty) {
            return errorUI('Tidak ada');
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 6),
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return buildUserListItem(user);
            },
          );
        }
      },
    );
  }

  Future<void> refresh() async {
    try {
      int saldo = await fetchOwnSaldo();
      selectedIndex = -1;
      setState(() {
        saldoFuture = saldo;
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      _userProfileFuture = filterUserProfiles('all');
    });
  }

  maintanance() {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Text("Sedang dalam maintanance"),
      ],
    );
  }

  errorUI(String error) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Text(error),
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

  buildUserListItem(UserProfile user) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                listImages(user, loveColor),
                SizedBox(width: 16),
                Container(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      userTypes(user),
                      userNames(user),
                      userRatings(user),
                      userDescriptions(user),
                      userPrices(user)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        greyLine(),
      ],
    );
  }

  Padding greyLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        thickness: 2,
        color: Color(0xFFF5F5F5),
      ),
    );
  }

  userPrices(UserProfile user) {
    (user.profile["gaji"]);
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

  SizedBox userDescriptions(UserProfile user) {
    (user.profile["deripsi"]);
    return SizedBox(
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
    );
  }

  String rattingNull(UserProfile user) {
    if (user.profile["rating"] == null) {
      return "0";
    } else {
      return user.profile["rating"].toString();
    }
  }

  Container userRatings(UserProfile user) {
    ('${user.profile["lama_pengalaman_bekerja"]}');
    return Container(
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
          Container(
            child: Row(
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
                '${user.profile["lama_pengalaman_bekerja"]}',
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

  Text userNames(UserProfile user) {
    (user.profile["nama_lengkap"]);
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

  Container userTypes(UserProfile user) {
    (user.category["name"]);
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
    ("$serverPath${user.profile["foto_setengah_badan"]}");
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
                  print(filter);
                  setState(() {
                    selectedIndex = index;
                    selectedCategory = types[index];
                    if (selectedCategory == 'ART') {
                      filter = 'art';
                    } else if (selectedCategory == 'Supir') {
                      filter = 'supir';
                    } else if (selectedCategory == 'Satpam') {
                      filter = 'satpam';
                    } else if (selectedCategory == 'Baby Sitter') {
                      filter = 'babysitter';
                    } else if (selectedCategory == 'PRT') {
                      filter = 'prt';
                    } else {
                      filter = 'all';
                    }
                    _userProfileFuture = filterUserProfiles(filter);
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
    final formattedSaldo = saldoFuture != null
        ? NumberFormat.decimalPattern('vi_VN').format(saldoFuture).toString()
        : '';

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
          child: saldoFuture == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(118, 231, 231, 231),
                      ),
                    ),
                    Container(),
                  ],
                )
              : Text(
                  isAmountVisible ? formattedSaldo : '-',
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
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/withdraw');
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

  // double measureTextWidth(String text, TextStyle style) {
  //   final TextPainter textPainter = TextPainter(
  //     text: TextSpan(text: text, style: style),
  //     textDirection: TextDirection.ltr,
  //   )..layout();

  //   return textPainter.width;
  // }

  // double measureTextWidthNew(String text) {
  //   final TextPainter textPainter = TextPainter(
  //     text: TextSpan(text: text),
  //     textDirection: TextDirection.ltr,
  //   )..layout();

  //   return textPainter.width;
  // }
}

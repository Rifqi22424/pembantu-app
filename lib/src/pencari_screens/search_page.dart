// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prt/main.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/limit_text.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  bool isFilterVisible = false;
  int? selectedUsia;
  int? selectedExp;
  String? selectedCity;
  String? selectedReligion;
  String namalengkap = '';
  int selectedIndex = 0;
  String? selectedCategory;
  String searchText = '';
  final FocusNode _focusNode = FocusNode();

  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  final List<String> types = [
    'All',
    'ART',
    'Supir',
    'Satpam',
    'Baby Sister',
    'PRT'
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: deviceTypeTablet() ? 400 : screenWidth,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.06),
                  searchNFilter(),
                  filterContents(),
                  selectCategory(),
                  buildUserList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  filterContents() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isFilterVisible ? 238 : 0,
      child: Form(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                usia(),
                pengalaman(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kota(),
                agama(),
              ],
            ),
            price(),
            SizedBox(height: 12),
            submitFilter(),
          ],
        ),
      ),
    );
  }

  searchNFilter() {
    return Container(
      width: 400,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          searchBox(),
          filterBox(),
        ],
      ),
    );
  }

  GestureDetector filterBox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFilterVisible = !isFilterVisible;
        });
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

  Container searchBox() {
    return Container(
      width: 280,
      height: 50,
      decoration: ShapeDecoration(
        color: Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Focus(
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            FocusScope.of(context).requestFocus(_focusNode);
          }
        },
        child: TextField(
          focusNode: _focusNode,
          onChanged: (text) {
            setState(() {
              searchText = text;
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
    );
  }

  selectCategory() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
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
                  if (index == 0) {
                    selectedIndex = index;
                    selectedCategory = null;
                  } else {
                    selectedIndex = index;
                    selectedCategory = types[index];
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
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
                  decoration: ShapeDecoration(
                    color: index == selectedIndex
                        ? Color(0x1939810D)
                        : Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
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

  submitFilter() {
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
        'Search',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container price() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 3),
            child: Text(
              'Rp. ',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 12,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
                height: 1.7,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 12,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Nominal maksimal',
                border: InputBorder.none,
                // contentPadding:
                //     EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                hintStyle: TextStyle(
                  color: Color(0xFF828993),
                  fontSize: 12,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                  height: 1.7,
                ),
              ),
              onSaved: (String? value) {
                namalengkap = value!;
              },
            ),
          ),
        ],
      ),
    );
  }

  Container agama() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 50,
      width: 170,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: DropdownButtonFormField<String>(
        icon: Image.asset('images/option.png'),
        hint: Text(
          'Agama',
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          hintStyle: TextStyle(fontSize: 12),
        ),
        value: selectedReligion, // Nilai yang terpilih
        items: <String>['Islam', 'Kristen'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(
            () {
              selectedReligion = newValue!; // Ubah nilai yang terpilih
            },
          );
        },
      ),
    );
  }

  kota() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 50,
      width: 170,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: DropdownButtonFormField<String>(
        icon: Image.asset('images/option.png'),
        hint: Text(
          'Kota',
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          hintStyle: TextStyle(fontSize: 12),
        ),
        value: selectedCity, // Nilai yang terpilih
        items: <String>['Jabar', 'Sukabumi'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedCity = newValue!; // Ubah nilai yang terpilih
          });
        },
      ),
    );
  }

  Container pengalaman() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 50,
      width: 170,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: DropdownButtonFormField<int>(
        icon: Image.asset('images/option.png'),
        hint: Text(
          'Pengalaman',
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          hintStyle: TextStyle(fontSize: 12),
        ),
        value: selectedExp, // Nilai yang terpilih
        items: <int>[1, 2, 3, 4].map((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text('$value'),
          );
        }).toList(),
        onChanged: (int? newValue) {
          setState(() {
            selectedExp = newValue!; // Ubah nilai yang terpilih
          });
        },
      ),
    );
  }

  Container usia() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      height: 50,
      width: 170,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: DropdownButtonFormField<int>(
        icon: Image.asset('images/option.png'),
        hint: Text(
          'Usia',
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          hintStyle: TextStyle(fontSize: 12),
        ),
        value: selectedUsia, // Nilai yang terpilih
        items: List<DropdownMenuItem<int>>.generate(
          11,
          (index) {
            return DropdownMenuItem<int>(
              value: 30 + index,
              child: Text((30 + index).toString()),
            );
          },
        ),
        onChanged: (newValue) {
          setState(() {
            selectedUsia = newValue;
          });
        },
      ),
    );
  }

  void _toggleUserLikedStatus(UserProfile user) {
    final newIsLiked = !user.isLiked;
    final userProvider = UserProvider(); // Create an instance
    userProvider.updateUserLikedStatus(
        user.profile["id"], newIsLiked); // Call the method on the instance
  }

  buildUserList() {
    return FutureBuilder<List<UserProfile>>(
      future: fetchUserProfiles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final usersFromAPI = snapshot.data;
          if (usersFromAPI == null || usersFromAPI.isEmpty) {
            return Text('Tidak ada data.');
          }

            List<UserProfile> filteredUsers = [];

          if (selectedCategory == null) {
            filteredUsers = usersFromAPI;
          } else {
            filteredUsers = usersFromAPI.where((user) {
              return user.category["name"] == selectedCategory;
            }).toList();
          }

          if (filteredUsers.isEmpty) {
            return Text("Tidak ada data");
          }


          return SizedBox(
            width: 400,
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 6),
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = usersFromAPI[index];
                return buildUserListItem(user);
              },
            ),
          );
        }
      },
    );
  }

  buildUserListItem(UserProfile user) {
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
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        'Rp. ${user.profile["gaji"]}',
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

  Container userRatings(UserProfile user) {
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
                '${user.profile["rating"]}',
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
    );
  }

  double measureTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width;
  }
}

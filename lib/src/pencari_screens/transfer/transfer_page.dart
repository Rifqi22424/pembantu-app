// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/models/chat_user_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String namalengkap = '';
  String selectedUser = '';
  CUser? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: deviceTypeTablet() ? 340 : screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  title(),
                  back(context),
                ],
              ),
              SizedBox(height: 32),
              saldoAnda(),
              SizedBox(height: 24),
              searchUser(),
              recommendUser(),
              Spacer(),
              transferButton(),
            ],
          ),
        ),
      ),
    );
  }

  saldoAnda() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Saldo Anda',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Rp. 10.000.000',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  title() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 65),
          child: Text(
            'Transfer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }

  back(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 60),
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

  searchUser() {
    return Center(
      child: Container(
        width: 320,
        height: 54,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: TextFormField(
          controller: TextEditingController(text: selectedUser),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: 'Masukan Nama',
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            hintStyle: TextStyle(
              color: Color(0xFF828993),
              fontSize: 12,
              fontFamily: 'Asap',
              fontWeight: FontWeight.w400,
            ),
          ),
          onSaved: (String? value) {
            namalengkap = value!;
          },
        ),
      ),
    );
  }

  recommendUser() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 12, bottom: 12),
        padding: EdgeInsets.only(left: 12, right: 12),
        height: 320,
        width: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xFFF6F6F6),
        ),
        child: ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 12),
            scrollDirection: Axis.vertical,
            itemCount: subscriptions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    selectedUser = favorites[index].name.toString();
                    selectedIndex = favorites[index];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFE7E7E7),
                        radius: 25,
                        backgroundImage: AssetImage(favorites[index].imageUrl),
                      ),
                      SizedBox(width: 12),
                      Text(
                        favorites[index].name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Asap',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  transferButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFF38800C)),
            minimumSize: MaterialStateProperty.all<Size>(Size(320, 44)),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/nominaltransfer',
                arguments: selectedIndex);
          },
          child: Text(
            'Transfer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

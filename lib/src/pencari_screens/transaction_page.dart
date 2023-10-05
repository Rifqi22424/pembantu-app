// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/models/cash_flow_model.dart';
import 'package:prt/src/models/chat_model.dart';
import 'package:prt/src/models/chat_user_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/limit_text.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isAmountVisible = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: deviceTypeTablet() ? 400 : screenWidth,
          child: Column(
            children: [
              _transactionText(),
              _saldo(),
              _paySubscription(),
              _recentActivityText(),
              _buildCashList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _botBar(context),
    );
  }

  Container _recentActivityText() {
    return Container(
      width: 330,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Activity',
            style: TextStyle(
              color: Color(0xFF06080C),
              fontSize: 14,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/cashflow');
            },
            child: Text(
              'View more',
              style: TextStyle(
                color: Color(0xFF39810D),
                fontSize: 12,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _transactionText() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Center(
        child: Text(
          'Transaksi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Padding _saldo() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: IntrinsicHeight(
        child: Container(
          width: 360,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          child: Stack(
            children: [
              backgroundPhoto(),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 18, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    saldoText(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        rpText(),
                        saldoOwn(),
                        visibleButton(),
                      ],
                    ),
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

  Divider line() {
    return Divider(
      color: Colors.white,
    );
  }

  GestureDetector cashFlowButton() {
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

  IconButton visibleButton() {
    return IconButton(
        onPressed: () {
          setState(() {
            isAmountVisible = !isAmountVisible;
          });
        },
        icon: Icon(
          isAmountVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.white,
          size: 20,
        ));
  }

  Expanded saldoOwn() {
    return Expanded(
      child: Text(
        isAmountVisible ? '10.000.000' : '-',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Text rpText() {
    return Text(
      'Rp. ',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ),
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

  Image backgroundPhoto() {
    return Image.asset(
      'images/SaldoBg.png',
      width: 360,
      height: 180,
      fit: BoxFit.fill,
    );
  }

  tarikTunaiButton() {
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
          crossAxisAlignment: CrossAxisAlignment.center,
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

  transferButton() {
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

  topUpButton() {
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
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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

  _paySubscription() {
    final double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 6),
      height: 100,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: screenwidth * 0.02),
        scrollDirection: Axis.horizontal,
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/nominaltransfer',
                  arguments: chats[index]);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
              child: Column(
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

  BottomAppBar _botBar(BuildContext context) {
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
              onPressed: () {}, icon: Image.asset('images/dolarGreen.png')),
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

  _buildCashList() {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: cashList.length,
        itemBuilder: (context, index) {
          final cash = cashList[index];
          return _buildCashListItem(cash);
        },
      ),
    );
  }

  _buildCashListItem(Cash cash) {
    final Color containerColor =
        cash.payOrBuy ? Color(0x19FF2E2E) : Color(0x192EB22B);
    final Color textColor =
        cash.payOrBuy ? Color(0xFFFF2E2E) : Color(0xFF2FB22C);
    final String titleText = cash.payOrBuy
        ? 'Pembayaran ke ${cash.titleflow}'
        : 'Uang Masuk dari ${cash.titleflow}';
    final String rp = cash.payOrBuy ? '-Rp. ' : 'Rp. ';
    return Column(
      children: [
        Container(
          width: 400,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(42),
                  ),
                ),
                child: Image.asset('images/dolarStack.png'),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${cash.date}',
                    style: TextStyle(
                      color: Color(0xFF828993),
                      fontSize: 10,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: ShapeDecoration(
                    color: containerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    )),
                child: Row(
                  children: [
                    Text(
                      rp,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 8,
                        fontFamily: 'Asap',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${cash.detailCash}',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 8,
                        fontFamily: 'Asap',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Divider(height: 1, thickness: 1, color: Color(0xffF1F1F1)),
        ),
      ],
    );
  }
}

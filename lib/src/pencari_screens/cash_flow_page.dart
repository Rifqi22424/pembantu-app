// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/api/digital_money.dart';
import 'package:prt/src/database/shared_preferences.dart';
import 'package:prt/src/models/transaction_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

import '../widgets/loading_history.dart';

class CashFlowPage extends StatefulWidget {
  const CashFlowPage({super.key});

  @override
  State<CashFlowPage> createState() => _CashFlowPageState();
}

class _CashFlowPageState extends State<CashFlowPage> {
  late Future<List<Transaction>> _fetchTransaction;
  int? userId;

  @override
  void initState() {
    super.initState();
    _fetchTransaction = DigitalMoney().fetchData();
    initializedUserId();
  }

  Future<void> initializedUserId() async {
    userId = await getIdFromSharedPreferences();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: deviceTypeTablet() ? 340 : screenWidth,
          child: Column(
            children: [
              Stack(
                children: [
                  back(context),
                  title(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _buildCashList(),
            ],
          ),
        ),
      ),
    );
  }

  title() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 65),
        child: Text(
          'Riwayat Pengeluaran',
          textAlign: TextAlign.center,
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

  back(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 60),
      child: GestureDetector(
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
    );
  }

  _buildCashList() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: SingleChildScrollView(
          child: FutureBuilder<List<Transaction>>(
            future: _fetchTransaction,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingData();
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No transactions available.'));
              } else {
                List<Transaction> transactions = snapshot.data!;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return _buildCashListItem(transaction);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  String titleTextLogic(Transaction transaction) {
    bool isIncrease = transaction.receiverId == userId;

    if (transaction.transactionType == 'topup') {
      return 'Melakukan Top Up';
    } else if (transaction.transactionType == 'transfer') {
      if (isIncrease) {
        return 'Uang Masuk dari ${transaction.receiverId}';
      } else {
        return 'Uang Keluar ke ${transaction.receiverId}';
      }
    } else {
      return 'Melakukan Tarik Tunai';
    }
  }

  _buildCashListItem(Transaction transaction) {
    bool isIncrease = userId == transaction.receiverId;
    final Color containerColor =
        isIncrease ? Color(0x192EB22B) : Color(0x19FF2E2E);
    final Color textColor = isIncrease ? Color(0xFF2FB22C) : Color(0xFFFF2E2E);
    final String rp = isIncrease ? 'Rp. ' : '-Rp. ';
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
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleTextLogic(transaction),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    formatOrderIdDate(transaction.orderId),
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
                      NumberFormat.decimalPattern('vi_VN')
                          .format(int.tryParse(transaction.nominal)),
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

  String formatOrderIdDate(String orderId) {
    String year = orderId.substring(2, 6);
    String month = orderId.substring(6, 8);
    String day = orderId.substring(8, 10);

    DateTime dateTime =
        DateTime(int.parse(year), int.parse(month), int.parse(day));

    String formattedDate = DateFormat('d MMM y', 'id_ID').format(dateTime);

    return formattedDate;
  }
}

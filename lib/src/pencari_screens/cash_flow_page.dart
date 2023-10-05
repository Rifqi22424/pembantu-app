// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:prt/src/models/cash_flow_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class CashFlowPage extends StatelessWidget {
  const CashFlowPage({super.key});

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
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 20),
      itemCount: cashList.length,
      itemBuilder: (context, index) {
        final cash = cashList[index];
        return _buildCashListItem(cash);
      },
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
              SizedBox(
                width: 12,
              ),
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

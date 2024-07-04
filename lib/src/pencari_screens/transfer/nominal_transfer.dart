// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/mixins/thousand_formatter.dart';
import 'package:prt/src/models/chat_user_model.dart';
import 'package:prt/src/widgets/get_device_type.dart';

import '../../api/digital_money.dart';

class NominalTransferPage extends StatefulWidget {
  final CUser user;
  final String tranferTarget;

  const NominalTransferPage(
      {super.key, required this.user, required this.tranferTarget});

  @override
  State<NominalTransferPage> createState() => _NominalTransferPageState();
}

class _NominalTransferPageState extends State<NominalTransferPage> {
  int? selectedPrice;
  bool isOverlayVisible = false;
  final DigitalMoney digitalMoney = DigitalMoney();
  List<int> prices = [
    100000,
    500000,
    1000000,
    1500000,
    3000000,
    3500000,
    4000000,
    4500000,
    5000000,
  ];
  int? saldoFuture;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchOwnSaldo().then((saldo) {
      setState(() {
        saldoFuture = saldo;
      });
    });
  }

  List<bool> containerStates = List.generate(9, (index) => false);
  TextEditingController topUpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: deviceTypeTablet() ? 340 : screenWidth,
          child: Stack(
            children: [
              Opacity(
                opacity: isOverlayVisible ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: isOverlayVisible ? true : false,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          title(),
                          back(context),
                        ],
                      ),
                      topUpBox(),
                      saldoAnda(),
                      InformationText(),
                      Spacer(),
                      transferButton(),
                    ],
                  ),
                ),
              ),
              if (isOverlayVisible) transferOverlay(context),
            ],
          ),
        ),
      ),
    );
  }

  saldoAnda() {
    final formattedSaldo = saldoFuture != null
        ? NumberFormat.decimalPattern('vi_VN').format(saldoFuture).toString()
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage('images/PayMethodBG.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              "Rp. $formattedSaldo",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
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

  Padding topUpBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 38, left: 24, right: 24),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Nominal Sebesar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rp. ',
                  style: TextStyle(
                    color: Color(0xFF080C11),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: selectedPrice != null
                        ? TextEditingController(
                            text: NumberFormat.decimalPattern('vi_VN')
                                .format(selectedPrice)
                                .toString())
                        : topUpController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Isi Nominal',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Color(0xFF080C11),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      NumberTextInputFormatter()
                    ],
                    onChanged: (String? value) {
                      if (value != null && value.isNotEmpty) {
                        selectedPrice =
                            int.tryParse(value.replaceAll('.', '')) ?? 0;
                      }
                    },
                    enabled: !isOverlayVisible,
                    autofocus: true,
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
              color: Color(0XFFE8E8E8),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  isOverlayVisible = true;
                });
              },
              child: Text(
                'Pilih Nominal Cepat',
                style: TextStyle(
                  color: Color(0xFF2B2B2B),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  transferButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
          minimumSize: WidgetStateProperty.all<Size>(Size(320, 44)),
        ),
        onPressed: () async {
          print(selectedPrice);
          if (selectedPrice == null) {
            _showTopSnackbar(context, 'Isi nominal top up!');
          } else if (selectedPrice! < 50000) {
            _showTopSnackbar(context, 'Minimal Transfer Rp. 50.000');
          } else {
            try {
              setState(() {
                isLoading = true;
              });
              bool success = await digitalMoney.transfer(selectedPrice!, 1, 1);
              if (success) {
                Navigator.pushNamed(context, '/struktransfer');
                setState(() {
                  isLoading = false;
                });
              }
            } catch (e) {
              _showTopSnackbar(
                  context, e.toString().replaceFirst('Exception: ', ''));
              setState(() {
                isLoading = false;
              });
            }
          }
        },
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                'Transfer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  void _showTopSnackbar(BuildContext context, String text) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: Color(0xFFFF2222), // Warna latar belakang
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    text,
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

  Padding InformationText() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
      child: Container(
        padding: EdgeInsets.only(top: 23, left: 24, right: 24, bottom: 26),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage('images/PayMethodBG.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Lengkap',
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Text(
              widget.tranferTarget,
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Divider(
              color: Color(0xFFE8E8E8),
              thickness: 2,
            ),
            SizedBox(height: 16),
            Text(
              'Nomor Handphone',
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '+6289612313214',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Divider(
              color: Color(0xFFE8E8E8),
              thickness: 2,
            ),
            SizedBox(height: 16),
            Text(
              'Email',
              style: TextStyle(
                color: Color(0xFF2B2B2B),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'anablacklight23@gmail.com',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  transferOverlay(context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 400,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _greyLine(),
            _titleOverlay(),
            Expanded(
              child: GridView(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: 60,
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2, // Ubah sesuai kebutuhan Anda
                ),
                children: List.generate(9, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        for (int i = 0; i < containerStates.length; i++) {
                          containerStates[i] = false;
                        }
                        containerStates[index] = true;
                        selectedPrice = prices[index];
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: containerStates[index]
                            ? Color(0xFFECF3E7)
                            : Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rp. ',
                            style: TextStyle(
                              color: containerStates[index]
                                  ? Color(0xFF38800C)
                                  : Color(0xFF080C11),
                              fontSize: 12,
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            NumberFormat.decimalPattern('vi_VN')
                                .format(prices[index]),
                            style: TextStyle(
                              color: containerStates[index]
                                  ? Color(0xFF38800C)
                                  : Color(0xFF080C11),
                              fontSize: 12,
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            _button(context),
          ],
        ),
      ),
    );
  }

  Padding _greyLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Center(
        child: Container(
          width: 64,
          height: 4,
          decoration: ShapeDecoration(
            color: Color(0xFFF3F3F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Padding _titleOverlay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Pilih Nominal',
        style: TextStyle(
          color: Color(0xFF080B11),
          fontSize: 22,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Center _button(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 16),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isOverlayVisible = false;
            });
          },
          child: Text('Next'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            backgroundColor: Color(0xFF38800C),
            minimumSize: Size(300, 50),
          ),
        ),
      ),
    );
  }
}

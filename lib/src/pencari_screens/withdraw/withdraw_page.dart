// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import '../../api/digital_money.dart';
import '../../mixins/thousand_formatter.dart';
import '../../models/pay_method_model.dart';

class WithDrawPage extends StatefulWidget {
  const WithDrawPage({super.key});

  @override
  State<WithDrawPage> createState() => _WithDrawPagePageState();
}

class _WithDrawPagePageState extends State<WithDrawPage> {
  final DigitalMoney digitalMoney = DigitalMoney();
  String namaRek = '';
  String noRek = '';

  final formKey = GlobalKey<FormState>();
  int selectedIndex = -1;
  int? selectedPrice;
  bool isOverlayTransferVisible = false;
  bool isOverlayPayMethodVisible = false;
  int? saldoFuture;
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
  List<bool> containerStates = List.generate(9, (index) => false);
  TextEditingController topUpController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          width: deviceTypeTablet() ? 340 : screenWidth,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isOverlayTransferVisible = false;
                    isOverlayPayMethodVisible = false;
                  });
                },
                child: Opacity(
                  opacity: isOverlayTransferVisible || isOverlayPayMethodVisible
                      ? 0.5
                      : 1.0,
                  child: AbsorbPointer(
                    absorbing:
                        isOverlayTransferVisible || isOverlayPayMethodVisible
                            ? true
                            : false,
                    child: Container(
                      margin: EdgeInsets.only(left: 24, bottom: 24, right: 24),
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
                          tarikTunaiText(),
                          SizedBox(height: 12),
                          withdrawBox(),
                          SizedBox(height: 20),
                          metodePenarikanText(),
                          SizedBox(height: 12),
                          payMethodContent(context),
                          SizedBox(height: 24),
                          Form(
                            key: formKey,
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  namaPenggunaText(),
                                  SizedBox(height: 12),
                                  _naRek(),
                                  SizedBox(height: 24),
                                  noRekText(),
                                  SizedBox(height: 12),
                                  _noRek(),
                                  Spacer(),
                                  submitButton(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (isOverlayTransferVisible) transferOverlay(context),
              if (isOverlayPayMethodVisible) PayMethodOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  PayMethodOverlay() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 300,
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
            greyLine(),
            titleOverlay(),
            PayMethodList(),
          ],
        ),
      ),
    );
  }

  Padding greyLine() {
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

  titleOverlay() {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: Center(
        child: Text(
          'Transfer Virtual Bank',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  PayMethodList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 6),
        itemCount: methodList.length,
        itemBuilder: (context, index) {
          final method = methodList[index];
          return PayMethodListItem(method, index);
        },
      ),
    );
  }

  PayMethodListItem(Method method, index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          for (var i = 0; i < methodList.length; i++) {
            methodList[i].isSelected = false;
          }
          method.isSelected = true;
          isOverlayPayMethodVisible = false;
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Container(
          color: method.isSelected ? Color(0xFFF5F5F5) : Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(method.imageUrl),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14),
              Text(
                method.nameBank,
                style: TextStyle(
                  color: Color(0xFF2B2B2B),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Text tarikTunaiText() {
    return Text(
      'Tarik Uang ',
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  submitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 54)),
      ),
      onPressed: () async {
        print('$namaRek, $noRek, $selectedPrice, $selectedIndex');

        // int nominal = selectedPrice!;
        // String bankImages = methodList[selectedIndex].imageUrl;
        // int bankIndex = methodList[selectedIndex].selectedIndex;
        formKey.currentState!.validate();
        formKey.currentState!.save();
        if (namaRek == '' ||
            noRek == '' ||
            selectedIndex == -1 ||
            selectedPrice == '') {
          _showTopSnackbar(context, "Lengkapi data yang diperlukan");
        } else {
          try {
            setState(() {
              isLoading = true;
            });
            bool success = await digitalMoney.withdraw(selectedPrice!, 1);
            if (success) {
              Navigator.pushNamed(context, '/strukwithdraw', arguments: {
                'nominal': selectedPrice!,
                'bankImages': "images/BRILogo.png",
              });
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
              'Withdraw',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
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
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    // Hilangkan Snackbar setelah beberapa detik (opsional)
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  _naRek() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'Masukan Nama Rekening',
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
        ),
        onSaved: (String? value) {
          namaRek = value!;
        },
      ),
    );
  }

  Widget _noRek() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Masukan No. Rekening',
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
        ),
        onSaved: (String? value) {
          noRek = value!;
        },
      ),
    );
  }

  Text noRekText() {
    return Text(
      'No. Rekening',
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text namaPenggunaText() {
    return Text(
      'Nama Rekening',
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text metodePenarikanText() {
    return Text(
      'Metode Penarikan',
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  saldoAnda() {
    final formattedSaldo = saldoFuture != null
        ? NumberFormat.decimalPattern('vi_VN').format(saldoFuture).toString()
        : '';

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: AssetImage('images/PayMethodBG.png'), fit: BoxFit.cover)),
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
    );
  }

  payMethodContent(context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: AssetImage('images/PayMethodDownBG.png'),
              fit: BoxFit.cover)),
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metode Pembayaran',
              style: TextStyle(
                color: Color(0xFF080C11),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  isOverlayPayMethodVisible = true;
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    selectedIndex == -1
                        ? 'images/wallet.png'
                        : methodList[selectedIndex].imageUrl,
                    width: 32,
                    height: 32,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedIndex == -1
                              ? 'Pilih Pembayaran'
                              : methodList[selectedIndex].nameBank,
                          style: TextStyle(
                            color: Color(0xFF2B2B2B),
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          'images/NavNext.png',
                          width: 20,
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
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
            'Withdraw',
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
      padding: const EdgeInsets.only(top: 60),
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

  withdrawBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nominal',
          style: TextStyle(
            color: Color(0xFF828993),
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                readOnly: true,
                controller: selectedPrice != null
                    ? TextEditingController(
                        text: NumberFormat.decimalPattern('vi_VN')
                            .format(selectedPrice)
                            .toString())
                    : topUpController,
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
                enabled: !isOverlayTransferVisible,
                autofocus: true,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isOverlayTransferVisible = true;
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
        padding: const EdgeInsets.only(top: 12, bottom: 16, left: 24, right: 24),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isOverlayTransferVisible = false;
            });
          },
          child: Text('Next'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            backgroundColor: Color(0xFF38800C),
            minimumSize: Size(double.maxFinite, 54),
          ),
        ),
      ),
    );
  }
}

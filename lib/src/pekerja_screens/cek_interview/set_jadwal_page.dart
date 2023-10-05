import 'package:flutter/material.dart';
import 'package:prt/src/widgets/get_device_type.dart';

class SetJadwalPage extends StatefulWidget {
  const SetJadwalPage({super.key});

  @override
  State<SetJadwalPage> createState() => SetJadwalPageState();
}

class SetJadwalPageState extends State<SetJadwalPage> {
  @override
  Widget build(BuildContext context) {
        final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: deviceTypeTablet()? 340 : screenWidth,
            child: Column(
              children: [
                Stack(
                  children: [
                    title(),
                    back(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center title() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 70),
          child: Text(
            'Set Jadwal',
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
}

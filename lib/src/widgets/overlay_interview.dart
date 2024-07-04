import 'package:flutter/material.dart';
import 'package:prt/src/widgets/overlay_costum_interview.dart';
import '../models/time_interview.dart';

class MyOverlayWidget extends StatefulWidget {
  final OverlayEntry overlayEntry;
  MyOverlayWidget({required this.overlayEntry});

  @override
  State<MyOverlayWidget> createState() => _MyOverlayWidgetState();
}

class _MyOverlayWidgetState extends State<MyOverlayWidget> {
  final List<String> time = ['9:00', '10:00', '12:00', '20.00'];
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  int selectedIndex = -1;
  late OverlayEntry overlayEntry;
  int selectedTimeIndex = -1;
  List<InterviewFree> interviewDates = generateInterviewFreeList();

  void showOverlayCostum(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (context) {
        return OverlayCostumInterview(
          overlayEntry: overlayEntry,
          overlayContext: context,
        );
      },
      maintainState: true,
      opaque: true,
    );

    Overlay.of(context).insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 350,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2),
                blurRadius: 5.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Container(
              padding:
                  EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  deleteButton(),
                  SizedBox(height: 22),
                  titleSchedule(),
                  SizedBox(height: 10),
                  descSchedule(),
                  SizedBox(height: 14),
                  dateText(),
                  SizedBox(height: 14),
                  listDates(),
                  SizedBox(height: 14),
                  timeText(),
                  SizedBox(height: 10),
                  listTimes(),
                  SizedBox(height: 22),
                  submitSchedule(),
                  SizedBox(height: 14),
                  submitCostum(navigatorKey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  deleteButton() {
    return GestureDetector(
      onTap: () {
        widget.overlayEntry.remove();
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Image.asset('images/xNoBG.png', width: 16, height: 16)),
    );
  }

  submitCostum(GlobalKey<NavigatorState> navigatorKey) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        minimumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 44)),
      ),
      onPressed: () {
        widget.overlayEntry.remove();
        showOverlayCostum(context);
      },
      child: Text(
        'Custom Schedule',
        style: TextStyle(
          color: Color(0xFF38800C),
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  submitSchedule() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 44)),
      ),
      onPressed: () {
        if (selectedIndex != -1 && selectedTimeIndex != -1) {
          widget.overlayEntry.remove();
          print('post to api');
        }
      },
      child: Text(
        'Schedule',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  listTimes() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: time.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTimeIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: ShapeDecoration(
                color: selectedTimeIndex == index
                    ? Color(0x1939810D)
                    : Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                time[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedTimeIndex == index
                      ? Color(0xFF38800C)
                      : Color(0xFF080C11),
                  fontSize: 14,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Text timeText() {
    return Text(
      'Time',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 16,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  listDates() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: interviewDates.length,
        itemBuilder: (context, index) {
          final interviewDate = interviewDates[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: IntrinsicHeight(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: ShapeDecoration(
                  color: index == selectedIndex
                      ? Color(0x1939810D)
                      : Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        '${interviewDate.day}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: index == selectedIndex
                              ? Color(0xFF38800C)
                              : Color(0xFF080C11),
                          fontSize: 16,
                          fontFamily: 'Asap',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      interviewDate.month,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: index == selectedIndex
                            ? Color(0xFF38800C)
                            : Color(0xFF828993),
                        fontSize: 12,
                        fontFamily: 'Asap',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Text dateText() {
    return Text(
      'Date',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 16,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text descSchedule() {
    return Text(
      'We hope that the interview will run smoothly and there will be no problems',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF828993),
        fontSize: 12,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
        height: 1.71,
      ),
    );
  }

  Text titleSchedule() {
    return Text(
      'Interview Schedule',
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 18,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

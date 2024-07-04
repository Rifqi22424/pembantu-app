import 'package:flutter/material.dart';

class OverlayCostumInterview extends StatefulWidget {
  final OverlayEntry overlayEntry;
  final BuildContext overlayContext;
  OverlayCostumInterview(
      {required this.overlayEntry, required this.overlayContext});
  @override
  State<OverlayCostumInterview> createState() => _MyOverlayWidgetState();
}

class _MyOverlayWidgetState extends State<OverlayCostumInterview> {
  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
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
              padding: EdgeInsets.all(24),
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  deleteLayout(),
                  SizedBox(height: 20),
                  titileCostumSchedule(),
                  SizedBox(height: 12),
                  descText(),
                  SizedBox(height: 32),
                  scheduleName(),
                  SizedBox(height: 16),
                  _timePickerButton(),
                  SizedBox(height: 16),
                  _datePickerButton(),
                  SizedBox(height: 32),
                  Expanded(
                    child: submitScheduleCostum(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  deleteLayout() {
    return GestureDetector(
      onTap: () {
        widget.overlayEntry.remove();
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Image.asset('images/xNoBG.png', width: 16, height: 16),
      ),
    );
  }

  Text titileCostumSchedule() {
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

  Text descText() {
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

  scheduleName() {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Master schedule name',
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
        style: TextStyle(
          color: Color(0xFF080C11),
          fontSize: 12,
          fontFamily: 'Asap',
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        onSaved: (String? value) {
          value = value!;
        },
      ),
    );
  }

  Widget _timePickerButton() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextButton(
        onPressed: () {
          _selectTime(widget.overlayContext);
        },
        child: Text(
          selectedTime == null
              ? '--:--'
              : 'Waktu: ${selectedTime!.hour}:${selectedTime!.minute}',
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
      ),
    );
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Widget _datePickerButton() {
    return Container(
      width: double.maxFinite,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: TextButton(
        onPressed: () {
          _selectDate(widget.overlayContext);
        },
        child: Text(
          selectedDate == null
              ? 'mm/dd/yy'
              : 'Schedule: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
          style: TextStyle(
            color: Color(0xFF080C11),
            fontSize: 12,
            fontFamily: 'Asap',
            fontWeight: FontWeight.w400,
            height: 1.7,
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  submitScheduleCostum() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF38800C)),
        minimumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 80)),
      ),
      onPressed: () {
        widget.overlayEntry.remove();
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
}

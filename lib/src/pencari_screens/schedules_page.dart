import 'package:flutter/material.dart';
import 'package:prt/src/api/interview_api.dart';
import 'package:prt/src/widgets/get_device_type.dart';

import '../../main.dart';
import '../api/fetch_user_data.dart';
import '../api/push_notif.dart';
import '../models/schedules_model.dart';
import '../widgets/scroll_behavior.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  Future<List<Schedules>> _fetchSchedules =
      InterviewApi().fetchSchedules('upcoming');
  int selectedIndex = 0;
  final List<String> types = ['Upcoming', 'Pending', 'Done', 'Pass', 'Reject'];
  String? selectedCategory;
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    fetchUserProfile().then((profile) {
      setState(() {
        userProfile = profile;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: deviceTypeTablet() ? 400 : screenWidth,
          child: Column(
            children: [
              Stack(
                children: [title(), back(context)],
              ),
              const SizedBox(height: 18),
              categoryNText(),
              selectCategory(),
              intervieWidget(screenWidth)
            ],
          ),
        ),
      ),
    );
  }

  Expanded intervieWidget(double screenWidth) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        width: 460,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(32)),
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: deviceTypeTablet() ? 340 : screenWidth,
              child: _buildInterviewList(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refresh() async {
    setState(() {
      _fetchSchedules = InterviewApi().fetchSchedules('pending');
    });
  }

  Widget loadingData() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildInterviewList() {
    print(_fetchSchedules);
    return RefreshIndicator(
      displacement: 10,
      onRefresh: refresh,
      color: Color(0xFF39810D),
      child: FutureBuilder<List<Schedules>>(
        future: _fetchSchedules,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingData();
          } else if (snapshot.hasError) {
            // return Center(child: Text('No interviews available.'));
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No interviews available.'));
          } else {
            List<Schedules> schedules = snapshot.data!;
            return ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  return _buildScheduleListItem(schedule);
                },
              ),
            );
          }
        },
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  _buildScheduleListItem(Schedules schedule) {
    print(schedule);
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
                child: ClipOval(
                    child: Image.network(
                  "$serverPath${schedule.fotoSetengahBadan}",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                )),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule.namaLengkap,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    formatDate(schedule.date),
                    style: const TextStyle(
                      color: Color(0xFF828993),
                      fontSize: 10,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              Spacer(),
              selectedIndex == 0
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                      child: IconButton(
                        onPressed: () {
                          FirebaseNotifAPI().sendNotification(
                              schedule.deviceToken,
                              userProfile!.email,
                              schedule.channelName,
                              schedule.channelToken);
                          Navigator.pushNamed(context, '/videocall',
                              arguments: {
                                'channel': schedule.channelName,
                                'token': schedule.channelToken,
                              });
                        },
                        icon: Icon(
                          Icons.camera_indoor_rounded,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Divider(height: 1, thickness: 1, color: Color(0xffF1F1F1)),
        ),
      ],
    );
  }

  categoryNText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16),
      child: SizedBox(
        width: 440,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            categoryText(),
          ],
        ),
      ),
    );
  }

  Text categoryText() {
    return Text(
      'Category',
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 14,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  selectCategory() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SizedBox(
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
                    selectedIndex = index;
                    selectedCategory = types[index];
                    // Update _fetchSchedules based on the selected category
                    switch (selectedCategory) {
                      case 'Done':
                        _fetchSchedules =
                            InterviewApi().fetchSchedules('done');
                        break;
                      case 'Upcoming':
                        _fetchSchedules =
                            InterviewApi().fetchSchedules('upcoming');
                        break;
                      case 'Pending':
                        _fetchSchedules =
                            InterviewApi().fetchSchedules('pending');
                        break;
                      case 'Pass':
                        _fetchSchedules =
                            InterviewApi().fetchSchedules('pass');
                        break;
                      case 'Reject':
                        _fetchSchedules =
                            InterviewApi().fetchSchedules('reject');
                        break;
                      default:
                        _fetchSchedules =
                            InterviewApi().fetchSchedules('pending');
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    decoration: ShapeDecoration(
                      color: index == selectedIndex
                          ? Color(0x1939810D)
                          : Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
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
                  ),
                ),
              );
            },
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
            'Schedules',
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
      padding: const EdgeInsets.only(left: 16, top: 60),
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

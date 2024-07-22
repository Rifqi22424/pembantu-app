// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prt/src/models/announcement_model.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

import '../provider/announcement_provider.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  @override
  void initState() {
    super.initState();
    context.read<AnnouncementProvider>().getAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    // AnnouncementService announcementService = AnnouncementService();

    // checkApi() async {
    //   // Future<Announcement> detail =
    //   //     announcementService.fetchAnnouncementDetail(1);
    //   // print(detail);
    //   List<Announcement> list = await announcementService.fetchAnnouncements();
    //   print(list);
    //   for (var announcement in list) {
    //     // print(announcement.id);
    //     // print(announcement.title);
    //     // print(announcement.message);
    //     // announcement.toString();
    //   }

    //   Announcement ann = await announcementService.fetchAnnouncementDetail(6);
    //   print(ann.toString());
    // }

    // checkApi();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              back(context),
              title(),
            ],
          ),
          _buildNotifList(),
        ],
      ),
    );
  }

  title() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 65),
          child: Text(
            'Notification',
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

   Future<void> _refreshAnnouncements() async {
    await context.read<AnnouncementProvider>().getAnnouncements();
  }

  _buildNotifList() {
    return Expanded(
      child: Consumer<AnnouncementProvider>(
        builder: (context, value, child) {
          switch (value.state) {
            case AnnouncementState.loading:
              return Center(child: CircularProgressIndicator());
            case AnnouncementState.loaded:
              if (value.announcements.isEmpty) {
                return Center(child: Text("Empty"));
              } else {
                return RefreshIndicator(
                  onRefresh: _refreshAnnouncements,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: value.announcements.length,
                      padding: EdgeInsets.only(top: 20),
                      itemBuilder: (context, index) {
                        final announcement = value.announcements[index];
                        return _buildNotifListItem(announcement);
                      },
                    ),
                  ),
                );
              }
            case AnnouncementState.error:
              return Center(
                child: Text(value.errorMessage ?? 'An Error occurred'),
              );
            default:
              return Container(); // Added default return statement
          }
        },
      ),
    );
  }

  String cutText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }

  String dateParse(String inputDate) {
    try {
      DateTime parsedDate = DateTime.parse(inputDate);

      String date =
          '${parsedDate.day.toString().padLeft(2, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}';
      String time =
          '${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}';

      String result = '$time:$date';
      print(result);
      return result;
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid date';
    }
  }

  _buildNotifListItem(Announcement announcement) {
    // final Image imageNotif = notif.typeNotif
    //     ? Image.asset('images/announce.png')
    //     : Image.asset('images/Message.png');
    print(DateTime.parse(announcement.createdAt));
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        '/detail_announcement',
        arguments: {'id': announcement.id},
      ),
      child: Column(
        children: [
          Container(
            // width: 400,
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
                  child: Image.asset("images/announce.png"),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Asap',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      cutText(announcement.subTitle, 30),
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
                  child: Text(
                    dateParse(announcement.createdAt),
                    style: TextStyle(
                      color: Color(0xFFB8BEC8),
                      fontSize: 10,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w400,
                    ),
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
      ),
    );
  }
}

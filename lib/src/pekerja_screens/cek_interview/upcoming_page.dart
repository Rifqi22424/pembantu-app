import 'package:flutter/material.dart';
import 'package:prt/src/api/interview_api.dart';
import 'package:prt/src/widgets/get_device_type.dart';
import '../../models/interview_model.dart';
import '../../widgets/scroll_behavior.dart';

class UpComingPage extends StatefulWidget {
  const UpComingPage({super.key});

  @override
  State<UpComingPage> createState() => _UpComingPageState();
}

class _UpComingPageState extends State<UpComingPage> {
  Future<List<Interview>> _fetchInterviews =
      InterviewApi().fetchInterviews('upcoming');

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: deviceTypeTablet() ? 340 : screenWidth,
            child: Column(
              children: [
                Stack(
                  children: [title(), back(context)],
                ),
                const SizedBox(height: 18),
                _buildInterviewList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildInterviewListItem(Interview interview) {
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
                // child: Image.asset(''),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    interview.pekerjaId.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    formatDate(interview.date),
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

  Widget loadingData() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  String formatDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  Future<void> refresh() async {
    setState(() {
      _fetchInterviews = InterviewApi().fetchInterviews('upcoming');
    });
  }

  Widget _buildInterviewList() {
    return RefreshIndicator(
      displacement: 10,
      onRefresh: refresh,
      color: Color(0xFF39810D),
      child: FutureBuilder<List<Interview>>(
        future: _fetchInterviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingData();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No interviews available.'));
          } else {
            List<Interview> interviews = snapshot.data!;
            return ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: interviews.length,
                itemBuilder: (context, index) {
                  final interview = interviews[index];
                  return _buildInterviewListItem(interview);
                },
              ),
            );
          }
        },
      ),
    );
  }

  Center title() {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 70),
          child: Text(
            'Upcoming',
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

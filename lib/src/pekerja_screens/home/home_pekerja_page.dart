import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prt/main.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/api/push_notif.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'package:prt/src/widgets/get_device_type.dart';

import '../../api/digital_money.dart';
import '../../api/interview_api.dart';
import '../../models/interview_model.dart';
import '../../widgets/scroll_behavior.dart';

class HomePekerjaPage extends StatefulWidget {
  const HomePekerjaPage({super.key});

  @override
  State<HomePekerjaPage> createState() => _HomePekerjaPageState();
}

class _HomePekerjaPageState extends State<HomePekerjaPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<List<Interview>> _fetchInterviews =
      InterviewApi().fetchInterviews('upcoming');
  List<Interview> interviews = [];
  final UserProvider userProvider = UserProvider();
  String search = '';
  bool isAmountVisible = true;
  int selectedIndex = 0;
  final List<String> types = ['Upcoming', 'Pending', 'Done', 'Pass', 'Reject'];
  String? selectedCategory;
  bool tabletDevice = deviceTypeTablet();
  InterviewApi inteviewApi = InterviewApi();

  UserProfile? userProfile;
  int? saldoFuture;

  void _removeInterview(Interview interview) {
    setState(() {
      interviews.remove(interview);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserProfile().then((profile) {
      setState(() {
        userProfile = profile;
      });
    });
    fetchOwnSaldo().then((saldo) {
      setState(() {
        saldoFuture = saldo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: deviceTypeTablet() ? 400 : screenWidth,
        height: screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mangCodingTextNRow(context),
            saldoContent(),
            categoryNText(),
            selectCategory(),
            intervieWidget(screenWidth)
          ],
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
        child: SizedBox(
          width: deviceTypeTablet() ? 340 : screenWidth,
          child: _buildInterviewList(),
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
                child: ClipOval(
                    child: Image.network(
                  "$serverPath${interview.fotoSetengahBadan}",
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
                    interview.email.length > 10
                        ? interview.email.substring(0, 10)
                        : interview.email,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        interview.time.toString(),
                        style: const TextStyle(
                          color: Color(0xFF828993),
                          fontSize: 10,
                          fontFamily: 'Asap',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        formatDate(interview.date),
                        style: const TextStyle(
                          color: Color(0xFF828993),
                          fontSize: 10,
                          fontFamily: 'Asap',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Spacer(),
              if (selectedIndex == 1)
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.1),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          bool updateStatus =
                              await inteviewApi.updateStatusInterview(
                                  true,
                                  interview.calendarId.toString(),
                                  interview.scheduleId.toString());
                          if (updateStatus) {
                            print("berhasi");
                            _removeInterview(interview);
                          } else {
                            print("gagal");
                          }
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Adjust spacing between buttons
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.withOpacity(0.1),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          bool updateStatus =
                              await inteviewApi.updateStatusInterview(
                                  false,
                                  interview.calendarId.toString(),
                                  interview.scheduleId.toString());
                          if (updateStatus) {
                            print("berhasi");
                            _removeInterview(interview);
                          } else {
                            print("gagal");
                          }
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              else if (selectedIndex == 0)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  child: IconButton(
                    onPressed: () {
                      FirebaseNotifAPI().sendNotification(
                          interview.deviceToken,
                          userProfile!.profile['nama_lengkap'],
                          interview.channelName,
                          interview.channelToken);
                      Navigator.pushNamed(context, '/videocall', arguments: {
                        'channel': interview.channelName,
                        'token': interview.channelToken,
                      });
                    },
                    icon: Icon(
                      Icons.camera_indoor_rounded,
                      color: Colors.blue,
                    ),
                  ),
                )
              else
                Container(),
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
      selectedCategory = types[selectedIndex];
      switch (selectedCategory) {
        case 'Done':
          _fetchInterviews = InterviewApi().fetchInterviews('done');
          break;
        case 'Upcoming':
          _fetchInterviews = InterviewApi().fetchInterviews('upcoming');
          break;
        case 'Pending':
          _fetchInterviews = InterviewApi().fetchInterviews('pending');
          break;
        case 'Pass':
          _fetchInterviews = InterviewApi().fetchInterviews('pass');
          break;
        case 'Reject':
          _fetchInterviews = InterviewApi().fetchInterviews('reject');
          break;
        default:
          _fetchInterviews = InterviewApi().fetchInterviews('pending');
      }
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
            interviews = snapshot.data!;
            print(interviews.length);
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

  Padding mangCodingTextNRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 45, right: 16),
      child: SizedBox(
        width: 600,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selamatdatangText(),
                mangcodingText(),
              ],
            ),
            GestureDetector(
              onTap: () {
                final userList = userProvider.users;

                Navigator.pushNamed(context, '/likedusers',
                    arguments: userList);
              },
              child: Row(
                children: [
                  SizedBox(width: 10),
                  notifPageButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector notifPageButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/notif');
      },
      child: Container(
        width: 34,
        height: 34,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.50,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Color(0xFFECECEC),
            ),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Image.asset(
                'images/Bell.png',
                width: 22,
                height: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding saldoContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 22, left: 16, right: 16),
      child: IntrinsicHeight(
        child: Container(
          width: 460,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          child: Stack(
            children: [
              backgroundImagesSaldo(),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 18, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    saldoText(),
                    ownSaldo(),
                    cashFlowButton(),
                    line(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        topUpButton(),
                        SizedBox(width: 10),
                        transferButton(),
                        SizedBox(width: 10),
                        tarikTunaiButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  categoryNText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
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
                    switch (selectedCategory) {
                      case 'Done':
                        _fetchInterviews =
                            InterviewApi().fetchInterviews('done');
                        break;
                      case 'Upcoming':
                        _fetchInterviews =
                            InterviewApi().fetchInterviews('upcoming');
                        break;
                      case 'Pending':
                        _fetchInterviews =
                            InterviewApi().fetchInterviews('pending');
                        break;
                      case 'Pass':
                        _fetchInterviews =
                            InterviewApi().fetchInterviews('pass');
                        break;
                      case 'Reject':
                        _fetchInterviews =
                            InterviewApi().fetchInterviews('reject');
                        break;
                      default:
                        _fetchInterviews =
                            InterviewApi().fetchInterviews('pending');
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

  Image backgroundImagesSaldo() {
    return Image.asset(
      'images/SaldoBg.png',
      width: 460,
      height: 200,
      fit: BoxFit.fill,
    );
  }

  Text mangcodingText() {
    return Text(
      'Mangcoding',
      style: TextStyle(
        color: Color(0xFF080C11),
        fontSize: 18,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text selamatdatangText() {
    return Text(
      'Selamat Datang',
      style: TextStyle(
        color: Color(0xFF828993),
        fontSize: 8,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  floatingButton() {
    return GestureDetector(
      onTap: () {},
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: Image.asset(
          'images/Phone.png',
          height: 24,
          width: 24,
        ),
      ),
    );
  }

  botBar(BuildContext context) {
    return BottomAppBar(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () {}, icon: Image.asset('images/Home.png')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/transaction');
              },
              icon: Image.asset('images/Dolar.png')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/listchat');
              },
              icon: Image.asset('images/Message.png')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: Image.asset('images/User.png')),
        ],
      ),
    );
  }

  Row ownSaldo() {
    final formattedSaldo = saldoFuture != null
        ? NumberFormat.decimalPattern('vi_VN').format(saldoFuture).toString()
        : '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Rp. ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
          child: Text(
            isAmountVisible ? formattedSaldo : '-',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                isAmountVisible = !isAmountVisible;
              });
            },
            icon: Icon(
              isAmountVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
              size: 20,
            ))
      ],
    );
  }

  Text saldoText() {
    return Text(
      'Saldo Anda',
      style: TextStyle(
        color: Color(0xFFEFEFEF),
        fontSize: 10,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  cashFlowButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/cashflow');
      },
      child: Row(
        children: [
          Text(
            'Riwayat pengeluaran',
            style: TextStyle(
              color: Color(0xFFEFEFEF),
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Image.asset(
              'images/NavigateNext.png',
              width: 21,
              height: 21,
            ),
          ),
        ],
      ),
    );
  }

  Divider line() {
    return Divider(
      color: Colors.white,
    );
  }

  Flexible tarikTunaiButton() {
    return Flexible(
      flex: 0,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/withdraw');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/Add.png',
                width: 12,
                height: 12,
              ),
              SizedBox(width: 6),
              Text(
                'Tarik Tunai',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Flexible transferButton() {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/transfer');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/Add.png',
                width: 12,
                height: 12,
              ),
              SizedBox(width: 6),
              Text(
                'Tranfer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Flexible topUpButton() {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/topup');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              )),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/Add.png',
                width: 12,
                height: 12,
              ),
              SizedBox(width: 6),
              Text(
                'Top Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _buildCashList() {
  //   return Expanded(
  //     child: ScrollConfiguration(
  //       behavior: NoGlowBehavior(),
  //       child: SingleChildScrollView(
  //         child: FutureBuilder<List<Map<String, dynamic>>>(
  //           future: _fetchData,
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return loadingData();
  //             } else if (snapshot.hasError) {
  //               return Center(child: Text('Error: ${snapshot.error}'));
  //             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //               return Center(child: Text('No transactions available.'));
  //             } else {
  //               List<Map<String, dynamic>> transactions = snapshot.data!;
  //               return ListView.builder(
  //                 padding: EdgeInsets.zero,
  //                 shrinkWrap: true,
  //                 physics: NeverScrollableScrollPhysics(),
  //                 itemCount: transactions.length,
  //                 itemBuilder: (context, index) {
  //                   final transaction = transactions[index];
  //                   return _buildCashListItem(transaction);
  //                 },
  //               );
  //             }
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // _buildCashListItem() {
  //   bool isIncrease = userId == transaction.receiverId;
  //   final Color containerColor =
  //       isIncrease ? Color(0x192EB22B) : Color(0x19FF2E2E);
  //   final Color textColor = isIncrease ? Color(0xFF2FB22C) : Color(0xFFFF2E2E);
  //   final String rp = isIncrease ? 'Rp. ' : '-Rp. ';
  //   return Column(
  //     children: [
  //       Container(
  //         width: 400,
  //         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //         padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Container(
  //               width: 40,
  //               height: 40,
  //               padding: EdgeInsets.all(8),
  //               decoration: ShapeDecoration(
  //                 color: Color(0xFFF5F5F5),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(42),
  //                 ),
  //               ),
  //               child: Image.asset('images/dolarStack.png'),
  //             ),
  //             SizedBox(
  //               width: 12,
  //             ),
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   titleTextLogic(transaction),
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 12,
  //                     fontFamily: 'Asap',
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 SizedBox(height: 4),
  //                 Text(
  //                   formatOrderIdDate(transaction.orderId),
  //                   style: TextStyle(
  //                     color: Color(0xFF828993),
  //                     fontSize: 10,
  //                     fontFamily: 'Asap',
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                 )
  //               ],
  //             ),
  //             Spacer(),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
  //               decoration: ShapeDecoration(
  //                   color: containerColor,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(24),
  //                   )),
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     rp,
  //                     style: TextStyle(
  //                       color: textColor,
  //                       fontSize: 8,
  //                       fontFamily: 'Asap',
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   Text(
  //                     '${transaction.nominal}',
  //                     style: TextStyle(
  //                       color: textColor,
  //                       fontSize: 8,
  //                       fontFamily: 'Asap',
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 24),
  //         child: Divider(height: 1, thickness: 1, color: Color(0xffF1F1F1)),
  //       ),
  //     ],
  //   );
  // }
}

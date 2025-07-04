// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/models/chat_model.dart';
import 'package:prt/src/models/chat_user_model.dart';
import 'package:prt/src/pekerja_screens/cek_interview/Pending_page.dart';
import 'package:prt/src/pekerja_screens/cek_interview/pass_page.dart';
import 'package:prt/src/pekerja_screens/cek_interview/reject_page.dart';
import 'package:prt/src/pekerja_screens/cek_interview/set_jadwal_page.dart';
import 'package:prt/src/pekerja_screens/cek_interview/upcoming_page.dart';
import 'package:prt/src/pekerja_screens/profile/edit_profile_pekerja.dart';
import 'package:prt/src/pekerja_screens/profile/profile_pekerja_page.dart';
import 'package:prt/src/pencari_screens/cash_flow_page.dart';
import 'package:prt/src/pencari_screens/chat/chat_page.dart';
import 'package:prt/src/pencari_screens/chat/incoming_video_call.dart';
import 'package:prt/src/pencari_screens/chat/video_call.dart';
import 'package:prt/src/pencari_screens/detail_announcement_page.dart';
import 'package:prt/src/pencari_screens/forgot_password/forgot_password_page.dart';
import 'package:prt/src/pencari_screens/home/detail_profile.dart';
import 'package:prt/src/pencari_screens/home/main_page.dart';
import 'package:prt/src/pencari_screens/liked_users_page.dart';
import 'package:prt/src/pencari_screens/login_page.dart';
import 'package:prt/src/pencari_screens/login_regist_page.dart';
import 'package:prt/src/pencari_screens/announcement_page.dart';
import 'package:prt/src/pencari_screens/message_page.dart';
import 'package:prt/src/pencari_screens/profile/edit_profile.dart';
import 'package:prt/src/pencari_screens/profile/profile_page.dart';
import 'package:prt/src/pencari_screens/regist/choose_page.dart';
import 'package:prt/src/pencari_screens/regist/regist_page.dart';
import 'package:prt/src/pencari_screens/regist/regist_pekerja_data_diri.dart';
import 'package:prt/src/pencari_screens/regist/regist_pekerja_keterangan.dart';
import 'package:prt/src/pencari_screens/regist/regist_pekerja_kontak_lain.dart';
import 'package:prt/src/pencari_screens/regist/regist_pekerja_pengalaman.dart';
import 'package:prt/src/pencari_screens/regist/regist_pencari_data_diri.dart';
import 'package:prt/src/pencari_screens/regist/verif_page.dart';
import 'package:prt/src/pencari_screens/schedules_page.dart';
import 'package:prt/src/pencari_screens/search_page.dart';
import 'package:prt/src/pencari_screens/splash_page.dart';
import 'package:prt/src/pencari_screens/topup/pay_method_page.dart';
import 'package:prt/src/pencari_screens/topup/struk_topup_page.dart';
import 'package:prt/src/pencari_screens/topup/top_up_page.dart';
import 'package:prt/src/pencari_screens/transfer/confirm_pin_page.dart';
import 'package:prt/src/pencari_screens/transfer/struk_transfer_page.dart';
import 'package:prt/src/pencari_screens/transfer/transfer_page.dart';
import 'package:prt/src/pencari_screens/withdraw/withdraw_page.dart';
import 'pekerja_screens/home/main_pekerja_page.dart';
import 'pencari_screens/transfer/nominal_transfer.dart';
import 'pencari_screens/welcome_page.dart';
import 'pencari_screens/withdraw/struk_withdraw.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashPage());
      case '/welcome':
        return MaterialPageRoute(builder: (context) => WelcomePage());
      case '/loginregist':
        return MaterialPageRoute(builder: (context) => LoginRegistPage());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/regist':
        return MaterialPageRoute(builder: (context) => RegistPage());
      case '/verif':
        final args = settings.arguments as Map<String, dynamic>;
        final String gmail = args['gmail'];
        return MaterialPageRoute(builder: (context) => VerifPage(gmail: gmail));
      case '/choose':
        return MaterialPageRoute(builder: (context) => ChoosePage());
      case '/registpekerjadatadiri':
        return MaterialPageRoute(builder: (context) => RegistPekerjaDataDiri());
      case '/registpekerjaketerangan':
        return MaterialPageRoute(
            builder: (context) => RegistPekerjaKeterangan());
      case '/registpekerjakontaklain':
        return MaterialPageRoute(
            builder: (context) => RegistPekerjaKontakLain());
      case '/registpekerjapengalaman':
        return MaterialPageRoute(
            builder: (context) => RegistPekerjaPengalaman());
      case '/registpencaridatadiri':
        return MaterialPageRoute(builder: (context) => RegistPencariDataDiri());
      case '/home':
        return MaterialPageRoute(builder: (context) => MainPage(index: 0));
      case '/detailprofile':
        final int userId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => DetailProfilePage(id: userId),
        );
      case '/notif':
        return MaterialPageRoute(builder: (context) => AnnouncementPage());
      case '/detail_announcement':
        final args = settings.arguments as Map<String, dynamic>;
        final int id = args['id'];
        return MaterialPageRoute(
            builder: (context) => DetailAnnouncementPage(
                  id: id,
                ));
      case '/likedusers':
        final List<UserProfile> userList =
            settings.arguments as List<UserProfile>;
        return MaterialPageRoute(
          builder: (context) => LikedUsersPage(userList: userList),
        );
      case '/search':
        final bool searchByText = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (context) => SearchPage(searchByText: searchByText),
        );
      case '/cashflow':
        return MaterialPageRoute(builder: (context) => CashFlowPage());
      case '/topup':
        return MaterialPageRoute(builder: (context) => TopUpPage());
      case '/paymethod':
        final args = settings.arguments as Map<String, dynamic>;
        final int digitTopUp = args['digitTopUp'];
        return MaterialPageRoute(
          builder: (context) => PayMethod(
            digitTopUp: digitTopUp,
          ),
        );
      case '/struktopup':
        final args = settings.arguments as Map<String, dynamic>;
        final int digitTopUp = args['digitTopUp'];
        final int bankIndex = args['bankIndex'];
        final String method = args['bankImages'];
        final String nameMethod = args['bankNames'];
        return MaterialPageRoute(
          builder: (context) => StrukTopUpPage(
            digitTopUp: digitTopUp,
            bankIndex: bankIndex,
            bankImages: method,
            bankNames: nameMethod,
          ),
        );
      case '/transaction':
        return MaterialPageRoute(builder: (context) => MainPage(index: 1));
      case '/transfer':
        return MaterialPageRoute(builder: (context) => TransferPage());
      case '/nominaltransfer':
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final CUser user = args['user'];
        final String transferTarget = args['transferTarget'];
        return MaterialPageRoute(
          builder: (context) => NominalTransferPage(
            user: user,
            tranferTarget: transferTarget,
          ),
        );
      case '/withdraw':
        return MaterialPageRoute(builder: (context) => WithDrawPage());
      case '/strukwithdraw':
        final args = settings.arguments as Map<String, dynamic>;
        final int nominal = args['nominal'];
        final String method = args['bankImages'];
        return MaterialPageRoute(
            builder: (context) => StrukWithDrawPage(
                  nominal: nominal,
                  bankImages: method,
                ));
      case '/confirmpin':
        return MaterialPageRoute(builder: (context) => ConfirmPinPage());
      case '/struktransfer':
        return MaterialPageRoute(builder: (context) => StrukTransferPage());
      case '/listchat':
        return MaterialPageRoute(builder: (context) => MainPage(index: 2));
      case '/chat':
        // final Chat user = settings.arguments as Chat;
        // final bool isRealUser = settings.arguments as bool;
        final args = settings.arguments as Map<String, dynamic>;
        final Chat user = args['user'];
        final bool isRealUser = args['isRealUser'];
        return MaterialPageRoute(
          builder: (context) => ChatPage(
            user: user,
            isRealUser: isRealUser,
          ),
        );
      case '/chatReal':
        // final Chat user = settings.arguments as Chat;
        // final bool isRealUser = settings.arguments as bool;
        final args = settings.arguments as Map<String, dynamic>;
        final UserProfile profile = args['profile'];
        final Chat user = args['user'];
        final bool isRealUser = args['isRealUser'];
        return MaterialPageRoute(
          builder: (context) => ChatPage(
            user: user,
            profile: profile,
            isRealUser: isRealUser,
          ),
        );
      case '/videocall':
        final args = settings.arguments as Map<String, dynamic>;
        final String channel = args['channel'];
        final String token = args['token'];

        return MaterialPageRoute(
          builder: (context) => VideoCall(
            channel: channel,
            token: token,
          ),
        );
      case '/profile':
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case '/message':
        // final NotificationResponse message =
        //     settings.arguments as NotificationResponse;
        return MaterialPageRoute(builder: (context) => MessagePage());
      case '/editprofile':
        return MaterialPageRoute(builder: (context) => EditProfilePage());
      case '/profilepekerja':
        return MaterialPageRoute(builder: (context) => ProfilePekerjaPage());
      case '/editprofilepekerja':
        return MaterialPageRoute(
            builder: (context) => EditProfilePekerjaPage());
      case '/pandding':
        return MaterialPageRoute(builder: (context) => PendingPage());
      case '/pass':
        return MaterialPageRoute(builder: (context) => PassPage());
      case '/reject':
        return MaterialPageRoute(builder: (context) => RejectPage());
      case '/setjadwal':
        return MaterialPageRoute(builder: (context) => SetJadwalPage());
      case '/upcoming':
        return MaterialPageRoute(builder: (context) => UpComingPage());
      case '/incomingcall':
        final args = settings.arguments as Map<String, dynamic>;
        final String channel = args['channel'];
        final String token = args['token'];

        return MaterialPageRoute(
            builder: (context) => IncomingVideoCall(
                  channelName: channel,
                  channelToken: token,
                ));
      case '/homepekerja':
        return MaterialPageRoute(
            builder: (context) => MainPekerjaPage(index: 0));
      case '/transactionpekerja':
        return MaterialPageRoute(
            builder: (context) => MainPekerjaPage(index: 1));
      case '/listchatpekerja':
        return MaterialPageRoute(
            builder: (context) => MainPekerjaPage(index: 2));
      case '/schedules':
        return MaterialPageRoute(builder: (context) => SchedulesPage());
      case '/forgotPassword':
        return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
    }
    return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (context) {
    return Scaffold(
      body: Center(
        child: Text('ERROR'),
      ),
    );
  });
}

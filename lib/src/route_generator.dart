// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/api/fetch_user_data.dart';
import 'package:prt/src/models/chat_model.dart';
import 'package:prt/src/models/chat_user_model.dart';
import 'package:prt/src/pekerja_screens/cek_interview/pandding_page.dart';
import 'package:prt/src/pekerja_screens/cek_interview/pass_page.dart';
import 'package:prt/src/pekerja_screens/cek_interview/reject_page.dart';
import 'package:prt/src/pekerja_screens/cek_interview/set_jadwal_page.dart';
import 'package:prt/src/pekerja_screens/cek_interview/upcoming_page.dart';
import 'package:prt/src/pekerja_screens/profile/edit_profile_pekerja.dart';
import 'package:prt/src/pekerja_screens/profile/profile_pekerja_page.dart';
import 'package:prt/src/pencari_screens/cash_flow_page.dart';
import 'package:prt/src/pencari_screens/chat/chat_page.dart';
import 'package:prt/src/pencari_screens/chat/incoming_video_call.dart';
import 'package:prt/src/pencari_screens/chat/list_chat_page.dart';
import 'package:prt/src/pencari_screens/chat/video_call.dart';
import 'package:prt/src/pencari_screens/home/detail_profile.dart';
import 'package:prt/src/pencari_screens/home/home_page.dart';
import 'package:prt/src/pencari_screens/liked_users_page.dart';
import 'package:prt/src/pencari_screens/login_page.dart';
import 'package:prt/src/pencari_screens/login_regist_page.dart';
import 'package:prt/src/pencari_screens/notif_page.dart';
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
import 'package:prt/src/pencari_screens/search_page.dart';
import 'package:prt/src/pencari_screens/splash_page.dart';
import 'package:prt/src/pencari_screens/topup/pay_method_page.dart';
import 'package:prt/src/pencari_screens/topup/struk_topup_page.dart';
import 'package:prt/src/pencari_screens/topup/top_up_page.dart';
import 'package:prt/src/pencari_screens/transaction_page.dart';
import 'package:prt/src/pencari_screens/transfer/confirm_pin_page.dart';
import 'package:prt/src/pencari_screens/transfer/struk_transfer_page.dart';
import 'package:prt/src/pencari_screens/transfer/transfer_page.dart';
import 'pencari_screens/transfer/nominal_transfer.dart';
import 'pencari_screens/welcome_page.dart';

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
        return MaterialPageRoute(builder: (context) => VerifPage());
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
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/detailprofile':
        final UserProfile user = settings.arguments as UserProfile;
        return MaterialPageRoute(
          builder: (context) => DetailProfilePage(user: user),
        );
      case '/notif':
        return MaterialPageRoute(builder: (context) => NotifPage());
      case '/likedusers':
        final List<UserProfile> userList =
            settings.arguments as List<UserProfile>;
        return MaterialPageRoute(
          builder: (context) => LikedUsersPage(userList: userList),
        );
      case '/search':
        return MaterialPageRoute(builder: (context) => SearchPage());
      case '/cashflow':
        return MaterialPageRoute(builder: (context) => CashFlowPage());
      case '/topup':
        return MaterialPageRoute(builder: (context) => TopUpPage());
      case '/paymethod':
        return MaterialPageRoute(builder: (context) => PayMethod());
      case '/struktopup':
        return MaterialPageRoute(builder: (context) => StrukTopUpPage());
      case '/transaction':
        return MaterialPageRoute(builder: (context) => TransactionPage());
      case '/transfer':
        return MaterialPageRoute(builder: (context) => TransferPage());
      case '/nominaltransfer':
        final CUser user = settings.arguments as CUser;
        return MaterialPageRoute(
          builder: (context) => NominalTransferPage(user: user),
        );
      case '/confirmpin':
        return MaterialPageRoute(builder: (context) => ConfirmPinPage());
      case '/struktransfer':
        return MaterialPageRoute(builder: (context) => StrukTransferPage());
      case '/listchat':
        return MaterialPageRoute(builder: (context) => ListChatPage());
      case '/chat':
        final Chat user = settings.arguments as Chat;
        return MaterialPageRoute(
          builder: (context) => ChatPage(user: user),
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
      case '/editprofile':
        return MaterialPageRoute(builder: (context) => EditProfilePage());

      case '/profilepekerja':
        return MaterialPageRoute(builder: (context) => ProfilePekerjaPage());
      case '/editprofilepekerja':
        return MaterialPageRoute(
            builder: (context) => EditProfilePekerjaPage());
      case '/pandding':
        return MaterialPageRoute(builder: (context) => PanddingPage());
      case '/pass':
        return MaterialPageRoute(builder: (context) => PassPage());
      case '/reject':
        return MaterialPageRoute(builder: (context) => RejectPage());
      case '/setjadwal':
        return MaterialPageRoute(builder: (context) => SetJadwalPage());
      case '/upcoming':
        return MaterialPageRoute(builder: (context) => UpComingPage());
      case '/incomingcall':
        return MaterialPageRoute(builder: (context) => InconmingVideoCall());
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

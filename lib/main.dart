import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prt/firebase_options.dart';
import 'package:prt/src/api/firebase_api.dart';
import 'package:prt/src/provider/announcement_provider.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'src/app.dart';
import 'package:provider/provider.dart';

const serverPath = "http://192.168.1.13:8080";
// const serverPath = "https://angle-app.mangcoding.com";

String? sharedToken;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'call_channel',
        channelName: 'Call Channel',
        channelDescription: 'Channel of calling',
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        enableVibration: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone)
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandlerTry);
  await FirebaseApi().initNotification();
  runApp(
      // ChangeNotifierProvider(
      //   create: (context) => UserProvider(),
      //   child: App(),
      // ),
      MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
      ChangeNotifierProvider<AnnouncementProvider>(
        create: (context) => AnnouncementProvider(),
      ),
    ],
    child: App(),
  ));
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandlerTry(
    RemoteMessage message) async {
  await Firebase.initializeApp();
  String? title = message.data['title'];
  String? body = message.data['body'];
  AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 123,
        channelKey: "call_channel",
        color: Colors.white,
        title: title,
        body: body,
        category: NotificationCategory.Call,
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Colors.white,
        timeoutAfter: const Duration(seconds: 15),
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'ACCEPT',
          label: "Accept Call",
          color: Colors.green,
          autoDismissible: true,
        ),
        NotificationActionButton(
            key: 'REJECT',
            label: "Reject Call",
            color: Colors.red,
            actionType: ActionType.DisabledAction,
            autoDismissible: true)
      ]);

  print("Handling a background message: ${message.messageId}");
}

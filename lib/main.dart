// import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prt/firebase_options.dart';
import 'package:prt/src/api/firebase_api.dart';
import 'package:prt/src/api/notification_service.dart';
import 'package:prt/src/provider/announcement_provider.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'package:vibration/vibration.dart';
import 'src/app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'src/database/shared_preferences.dart';

const serverPath = "http://192.168.207.13:3000";
// const serverPath = "https://p3gm9glm-8000.asse.devtunnels.ms";
// const serverPath = "https://angle-app.mangcoding.com";

String? sharedToken;
final navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // if (message.notification != null) {
  print("Some notification Received in background...");
  // String payloadData = jsonEncode(message);
  // print(payloadData);
  print(message.data);

  _showNotification(message);

  // }
}

Future<void> _showNotification(RemoteMessage message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    '0',
    'Notification',
    importance: Importance.max,
    priority: Priority.high,
    ongoing: true,
    // playSound: true,
    // sound: RawResourceAndroidNotificationSound('phone'),
    enableVibration: true,
    fullScreenIntent: true,
    visibility: NotificationVisibility.public,
    vibrationPattern:
        Int64List.fromList([0, 1000, 1000, 1000, 1000, 1000, 1000, 1000]),
    actions: <AndroidNotificationAction>[
      AndroidNotificationAction('ACCEPT_CALL', 'Accept',
          icon: DrawableResourceAndroidBitmap('ic_accept'),
          showsUserInterface: true,
          cancelNotification: true,
          titleColor: Colors.green),
      AndroidNotificationAction('REJECT_CALL', 'Reject',
          icon: DrawableResourceAndroidBitmap('ic_reject'),
          showsUserInterface: true,
          cancelNotification: true,
          titleColor: Colors.red),
    ],
    timeoutAfter: 10000, // Notification will disappear after 10 seconds
  );
  // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'Incoming Interview Video Call',
    '${message.data['caller'] ?? "Someone"} is calling you',
    platformChannelSpecifics,
    payload: message.data.toString(),
  );

  Vibration.vibrate(pattern: [2000, 2000, 2000, 2000, 2000], repeat: 2);

  FlutterRingtonePlayer.play(
    android: AndroidSounds.ringtone,
    ios: IosSounds.glass,
    looping: true,
    volume: 1.0,
    asAlarm: false,
  );

  Future.delayed(Duration(seconds: 10), () {
    Vibration.cancel();
    FlutterRingtonePlayer.stop();
  });
}

@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  if (notificationResponse.payload != null) {
    final String? a = notificationResponse.actionId;
    final String? b = notificationResponse.input;
    final String? payload = notificationResponse.payload;
    final int? d = notificationResponse.id;
    final NotificationResponseType e =
        notificationResponse.notificationResponseType;
    debugPrint('notification action id: $a');
    debugPrint('notification input: $b');
    debugPrint('notification payload: $payload');
    debugPrint('notification id: $d');
    debugPrint('notification type: $e');

    try {
      final channelPattern = RegExp(r'"channel":"([^"]+)"');
      final tokenPattern = RegExp(r'"token":"([^"]+)"');

      final channelMatch = channelPattern.firstMatch(payload!);
      final tokenMatch = tokenPattern.firstMatch(payload);

      final String channel = channelMatch?.group(1) ?? '';
      final String token = tokenMatch?.group(1) ?? '';

      print('Channel: $channel');
      print('Token: $token');

      final String? actionId = notificationResponse.actionId;
      final int? notificationId = notificationResponse.id;

      if (actionId == 'ACCEPT_CALL') {
        print('Call Accepted');
        Future.delayed(Duration(seconds: 3), () async {
          await flutterLocalNotificationsPlugin.cancel(notificationId!);
          navigatorKey.currentState?.pushNamed('/videocall', arguments: {
            'channel': channel,
            'token': token,
          });
          Vibration.cancel();
          FlutterRingtonePlayer.stop();
        });
      } else if (actionId == 'REJECT_CALL') {
        print('Call Rejected');
        await flutterLocalNotificationsPlugin.cancel(notificationId!);
        Vibration.cancel();
        FlutterRingtonePlayer.stop();
      } else if (actionId == null) {
        Future.delayed(
          Duration(seconds: 3),
          () async {
            Vibration.cancel();
            FlutterRingtonePlayer.stop();
            navigatorKey.currentState?.pushNamed('/incomingcall', arguments: {
              'channel': channel,
              'token': token,
            });
          },
        );
      }
    } catch (e) {
      print('Error parsing payload: $e');
    }
  }
}

Future<void> _handleMessage(RemoteMessage message) async {
  final payload = message.data.toString();

  final channelPattern = RegExp(r'"channel":"([^"]+)"');
  final tokenPattern = RegExp(r'"token":"([^"]+)"');

  final channelMatch = channelPattern.firstMatch(payload);
  final tokenMatch = tokenPattern.firstMatch(payload);

  final String channel = channelMatch?.group(1) ?? '';
  final String token = tokenMatch?.group(1) ?? '';

  // Delay navigation to ensure app is fully initialized
  Future.delayed(Duration(seconds: 3), () async {
    navigatorKey.currentState!.pushNamed('/incomingcall', arguments: {
      'channel': channel,
      'token': token,
    });
  });
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: false, badge: false, sound: false);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  await FirebaseApi().initNotification();

  await PushNotifications.init();

  if (!kIsWeb) {
    await PushNotifications.localNotiInit();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      // _showNotification(message);
      _handleMessage(message);
    }
  });

// to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    print(payloadData);
    _showNotification(message);
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    // _handleMessage(message);

    // _showNotification(message);

    Future.delayed(Duration(seconds: 2), () async {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  } else {}

  var details = await PushNotifications.flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails();
  if (details?.didNotificationLaunchApp ?? false) {
    // print(details!.notificationResponse!);
    saveMsgToSharedPreferences(
        details!.notificationResponse!.actionId.toString());
    onDidReceiveNotificationResponse(details.notificationResponse!);
  } else {
    saveMsgToSharedPreferences("not working");
  }
  String? msg = await getMsgFromSharedPreferences();
  print("message: $msg");

  await initializeDateFormatting('id_ID', null);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
      ChangeNotifierProvider<AnnouncementProvider>(
        create: (context) => AnnouncementProvider(),
      ),
    ],
    child: App(navigatorKey: navigatorKey),
  ));
}

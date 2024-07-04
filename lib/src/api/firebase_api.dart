import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:prt/main.dart';
import 'package:prt/src/database/shared_preferences.dart';
import 'package:prt/src/pencari_screens/chat/incoming_video_call.dart';
import 'package:prt/src/pencari_screens/chat/video_call.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    final FCMToken = await _firebaseMessaging.getToken();

    print('Token: $FCMToken');

    saveDeviceTokenToSharedPreferences(FCMToken!);

    initPushNotif();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    final data = message.data;
    final channel = data['channel'];
    final token = data['token'];

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => VideoCall(
          token: token,
          channel: channel,
        ),
      ),
    );
  }

  void handleMessageOnApp(RemoteMessage? message) async {
    if (message == null) return;

    final data = message.data;
    final channel = data['channel'];
    final token = data['token'];

    await saveVcallTokenToSharedPreferences(token);
    await saveVcallNameToSharedPreferences(channel);

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const IncomingVideoCall(),
      ),
    );
  }

  void handleMessageApp(RemoteMessage message) async {
    final data = message.data;
    final channel = data['channel'];
    final token = data['token'];

    await saveVcallTokenToSharedPreferences(token);
    await saveVcallNameToSharedPreferences(channel);

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const IncomingVideoCall(),
      ),
    );
    
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
          channelKey: "call_channel",
          color: Colors.white,
          title: 'title',
          body: 'body',
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.orange,
        ),
        actionButtons: [
          NotificationActionButton(
              key: 'ACCEPT',
              label: "Accept Call",
              color: Colors.green,
              autoDismissible: true),
          NotificationActionButton(
              key: 'REJECT',
              label: "Reject Call",
              color: Colors.red,
              autoDismissible: true)
        ]);
  }

  Future initPushNotif() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessageOnApp);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageApp);

    FirebaseMessaging.onMessage.listen(handleMessageApp);

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  @pragma('vm:entry-point')
  Future<void> backgroundHandler(RemoteMessage message) async {
    print('background have trigered');
    String? title = message.notification!.title;
    String? body = message.notification!.body;
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
          channelKey: "call_channel",
          color: Colors.white,
          title: title,
          body: body,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.orange,
        ),
        actionButtons: [
          NotificationActionButton(
              key: 'ACCEPT',
              label: "Accept Call",
              color: Colors.green,
              autoDismissible: true),
          NotificationActionButton(
              key: 'REJECT',
              label: "Reject Call",
              color: Colors.red,
              autoDismissible: true)
        ]);
  }

  Future<void> backgroundHandlerInApp(RemoteMessage message) async {
    String? title = message.notification!.title;
    String? body = message.notification!.body;

    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
          channelKey: "call_channel",
          color: Colors.white,
          title: title,
          body: body,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.orange,
        ),
        actionButtons: [
          NotificationActionButton(
              key: 'ACCEPT',
              label: "Accept Call",
              color: Colors.green,
              autoDismissible: true),
          NotificationActionButton(
            key: 'REJECT',
            label: "Reject Call",
            color: Colors.red,
            autoDismissible: true,
          )
        ]);
  }
}

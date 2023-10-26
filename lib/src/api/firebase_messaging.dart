// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   NotificationService() {
//     initialize();
//   }

//   void initialize() {
//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         if (message['data']['type'] == 'video_call') {
//           // Tindakan yang sesuai saat menerima notifikasi video call
//         }
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         // Tindakan yang sesuai saat pengguna mengklik notifikasi yang memulai aplikasi
//       },
//       onResume: (Map<String, dynamic> message) async {
//         // Tindakan yang sesuai saat pengguna mengklik notifikasi saat aplikasi sedang berjalan
//       },
//     );
//   }

//   // Fungsi untuk mengirim notifikasi
//   Future<void> sendNotification(String receiverFID, Map<String, dynamic> data) async {
//     await _firebaseMessaging.send(
//       to: receiverFID,
//       data: data,
//     );
//   }
// }

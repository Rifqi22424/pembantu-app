// // ignore_for_file: prefer_const_constructors

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// const appId = "3e874f1eccfd454aaba44497474a4026";
// const token =
//     "007eJxTYLij63z/8L0HgiI8KYcmHohY8crzy/+8gHedgSI+xRsNA7kUGIxTLcxN0gxTk5PTUkxMTRITkxJNTEwszU3MTRJNDIzMzsXKpTYEMjJ0FV5mYWSAQBCfnaEktbgkMy+dgQEA8iUhPw==";
// const channel = "testing";

// class VideoCall extends StatefulWidget {
//   const VideoCall({Key? key}) : super(key: key);

//   @override
//   State<VideoCall> createState() => _VideoCallState();
// }

// class _VideoCallState extends State<VideoCall> {
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;
//   bool _isCameraMuted = false;
//   bool _isMicMuted = false;
//   bool _isFrontCamera = true;

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   Future<void> initAgora() async {
//     // retrieve permissions
//     await [Permission.microphone, Permission.camera].request();

//     //create the engine
//     _engine = createAgoraRtcEngine();
//     await _engine.initialize(const RtcEngineContext(
//       appId: appId,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));

//     _engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("local user ${connection.localUid} joined");
//           setState(() {
//             _localUserJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("remote user $remoteUid joined");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           debugPrint("remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
//           debugPrint(
//               '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
//         },
//       ),
//     );

//     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
//     await _engine.enableVideo();
//     await _engine.startPreview();

//     await _engine.joinChannel(
//       token: token,
//       channelId: channel,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }

//   void endCall() async {
//     await _engine.leaveChannel();
//     await _engine.stopPreview();
//     setState(() {
//       _localUserJoined = false;
//       _remoteUid = null;
//     });
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pop();
//   }

//   void toggleMuteCamera() async {
//     _isCameraMuted = !_isCameraMuted;
//     await _engine.muteLocalVideoStream(_isCameraMuted);
//     setState(() {});
//   }

//   void toggleMic() async {
//     _isMicMuted = !_isMicMuted;
//     await _engine.muteLocalAudioStream(_isMicMuted);
//     setState(() {});
//   }

//   void toggleReverseCamera() {
//     _isFrontCamera = !_isFrontCamera;
//     _engine.switchCamera();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 50, left: 20),
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: SizedBox(
//                 width: 100,
//                 height: 160,
//                 child: Center(
//                   child: _localUserJoined
//                       ? AgoraVideoView(
//                           controller: VideoViewController(
//                             rtcEngine: _engine,
//                             canvas: const VideoCanvas(uid: 0),
//                           ),
//                         )
//                       : const CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 60),
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   endCallButton(),
//                   SizedBox(height: 40),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       onOffMic(),
//                       SizedBox(width: 40),
//                       reverseCam(),
//                       SizedBox(width: 40),
//                       onOffCam(),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   endCallButton() {
//     return GestureDetector(
//       onTap: () {
//         endCall();
//       },
//       child: Image.asset('images/end_call.png', width: 60, height: 60),
//     );
//   }

//   onOffCam() {
//     return GestureDetector(
//       onTap: () {
//         toggleMuteCamera();
//       },
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.2),
//           shape: BoxShape.circle,
//         ),
//         child: _isCameraMuted
//             ? Image.asset('images/cam_off.png', width: 30, height: 30)
//             : Image.asset('images/cam.png', width: 30, height: 30),
//       ),
//     );
//   }

//   reverseCam() {
//     return GestureDetector(
//       onTap: () {
//         toggleReverseCamera();
//       },
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.2),
//           shape: BoxShape.circle,
//         ),
//         child: Image.asset('images/reverse_cam.png', width: 30, height: 30),
//       ),
//     );
//   }

//   onOffMic() {
//     return GestureDetector(
//       onTap: () {
//         toggleMic();
//       },
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.2),
//           shape: BoxShape.circle,
//         ),
//         child: _isMicMuted
//             ? Image.asset('images/mic_off.png', width: 30, height: 30)
//             : Image.asset('images/mic.png', width: 30, height: 30),
//       ),
//     );
//   }

//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: const RtcConnection(channelId: channel),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }

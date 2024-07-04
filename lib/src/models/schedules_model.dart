class Schedules {
  final int id;
  final int calendarId;
  final int pekerjaId;
  final DateTime date;
  final String time;
  final String status;
  final String namaLengkap;
  final int userId;
  final String channelToken;
  final String channelName;
  final String fotoSetengahBadan;
  final String deviceToken;

  Schedules(
      {required this.id,
      required this.calendarId,
      required this.pekerjaId,
      required this.date,
      required this.time,
      required this.status,
      required this.namaLengkap,
      required this.userId,
      required this.channelToken,
      required this.channelName,
      required this.deviceToken,
      required this.fotoSetengahBadan});

  // factory Schedules.fromJson(Map<String, dynamic> json) {
  //   return Schedules(
  //     userId: json['interview_calendar']?['user']?['profile']?['user_id'] ?? "",
  //     id: json['id'] ?? 0,
  //     calendarId: json['calendar_id'] ?? 0,
  //     pekerjaId: json['interview_calendar']?['pekerja_id'] ?? 0,
  //     date: DateTime.parse(json['interview_calendar']?['date']),
  //     time: json['interview_calendar']?['time'] ?? "",
  //     status: json['interview_calendar']?['status'],
  //     namaLengkap: json['interview_calendar']?['user']?['profile'] ?? "",
  //     fotoSetengahBadan: json['interview_calendar']?['user']?['profile']
  //             ?['foto_setengah_badan'] ??
  //         "",
  //     channelName: json['channelname'] ?? "",
  //     channelToken: json['channeltoken'] ?? "",
  //     deviceToken: json['interview_calendar']?['user']?['device_token'] ?? "",
  //   );
  // }
   factory Schedules.fromJson(Map<String, dynamic> json) {
    return Schedules(
      userId: json['interview_calendar']?['user']?['id'] ?? 0,
      id: json['id'] ?? 0,
      calendarId: json['calendar_id'] ?? 0,
      pekerjaId: json['interview_calendar']?['pekerja_id'] ?? 0,
      date: DateTime.parse(json['interview_calendar']?['date']),
      time: json['interview_calendar']?['time'] ?? "",
      status: json['status'] ?? "",
      namaLengkap: json['interview_calendar']?['user']?['profile']?['nama_lengkap'] ?? "",
      fotoSetengahBadan: json['interview_calendar']?['user']?['profile']?['foto_setengah_badan'] ?? "",
      channelName: json['channelname'] ?? "",
      channelToken: json['channeltoken'] ?? "",
      deviceToken: json['interview_calendar']?['user']?['device_token'] ?? "",
    );
  }
}

class Interview {
  final int calendarId;
  final int scheduleId;
  final int pekerjaId;
  final DateTime date;
  final String time;
  final String status;
  final String email;
  final String fotoSetengahBadan;
  final String channelToken;
  final String channelName;
  final String deviceToken;

  Interview(
      {required this.calendarId,
      required this.scheduleId,
      required this.pekerjaId,
      required this.date,
      required this.time,
      required this.status,
      required this.email,
      required this.fotoSetengahBadan,
      required this.channelToken,
      required this.channelName,
      required this.deviceToken});

  factory Interview.fromJson(Map<String, dynamic> json) {
    return Interview(
        calendarId: json['id'] ?? 0,
        scheduleId: json['interview_schedule']?['id'] ?? 0,
        pekerjaId: json['pekerja_id'] ?? 0,
        date: DateTime.parse(json['date']),
        time: json['time'],
        status: json['status'],
        email: json['interview_schedule']?['user']?['email'] ??
            "",
        fotoSetengahBadan: json['interview_schedule']?['user']?['profile']
                ?['foto_setengah_badan'] ??
            "",
        channelName: json['interview_schedule']?['channelname'] ?? "",
        channelToken: json['interview_schedule']?['channeltoken'] ?? "",
        deviceToken: json['inteview_schedule']?['user']?['device_token'] ?? "");
  }
}

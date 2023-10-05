// ignore_for_file: non_constant_identifier_names

class Notif {
  final String sender;
  final String date;
  final String message;
  final bool typeNotif;

  Notif(
      {required this.sender,
      required this.date,
      required this.message,
      required this.typeNotif});
}

final Notif sarahJones = Notif(
    sender: 'Sarah',
    date: '10:23',
    message: 'Jadwal Schedule Interview',
    typeNotif: false);

final Notif mangcoding = Notif(
    sender: 'Mangcoding',
    date: '12:23',
    message: 'Top Up ke Dompet digital..',
    typeNotif: true);

final Notif sarahJones2 = Notif(
    sender: 'Sarah',
    date: '13:00',
    message: 'Jadwal Schedule Interview',
    typeNotif: false);

final Notif sarahJones3 = Notif(
    sender: 'Sarah',
    date: '10:23',
    message: 'Jadwal Schedule Interview',
    typeNotif: false);

final Notif sarahJones4 = Notif(
    sender: 'Sarah',
    date: '10:23',
    message: 'Jadwal Schedule Interview',
    typeNotif: false);

final List<Notif> NotifList = [
  sarahJones,
  mangcoding,
  sarahJones2,
  sarahJones3,
  sarahJones4,
];

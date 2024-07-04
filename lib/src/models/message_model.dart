import 'chat_user_model.dart';

class Message {
  final CUser sender;
final String text;
  final String time;

  Message({required this.sender, required this.text, required this.time});
}

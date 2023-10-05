import 'package:prt/src/models/chat_user_model.dart';

class Chat {
  final String imageUrl;
  final CUser sender;
  final String lastMessage;
  final String time;
  final String unRead;

  Chat({
    required this.imageUrl,
    required this.sender,
    required this.lastMessage,
    required this.time,
    required this.unRead,
  });
}

final List<Chat> chats = [
  Chat(
    imageUrl: 'images/John.jpg',
    sender: johnDoe,
    lastMessage: 'Hello, how are you?',
    time: '10:30 AM',
    unRead: '2',
  ),
  Chat(
    imageUrl: 'images/Sarah.jpg',
    sender: sarahJones,
    lastMessage: 'See you later!',
    time: '11:45 AM',
    unRead: '10',
  ),
  Chat(
    imageUrl: 'images/Emily.jpg',
    sender: emilySmith,
    lastMessage:
        'Let\'s meet up tomorrow. I just meet someone in the street and he just hook up on me, he\'s so gorgeus, im litle bit nervous right now, you won\'t believe it',
    time: '1:20 PM',
    unRead: '',
  ),
  Chat(
    imageUrl: 'images/Michael.jpg',
    sender: michaelBrown,
    lastMessage: 'Have a great day!',
    time: '3:15 PM',
    unRead: '',
  ),
  Chat(
    imageUrl: 'images/William.jpg',
    sender: lindaWilliams,
    lastMessage: 'Thanks for your help.',
    time: '5:00 PM',
    unRead: '',
  ),
  Chat(
    imageUrl: 'images/David.jpg',
    sender: davidMiller,
    lastMessage: 'Thanks for your help.',
    time: '5:00 PM',
    unRead: '',
  ),
  Chat(
    imageUrl: 'images/Olivia.jpg',
    sender: oliviaWilson,
    lastMessage: 'Thanks for your help.',
    time: '5:00 PM',
    unRead: '',
  ),
  Chat(
    imageUrl: "images/Ava.jpg",
    sender: avaAnderson,
    lastMessage: 'Thanks for your help.',
    time: '5:00 PM',
    unRead: '',
  ),
];

final List<Chat> newChats = [
  Chat(
    imageUrl: 'images/John.jpg',
    sender: currentUser,
    lastMessage: 'Hey John, how\'s it going?',
    time: '6:45 PM',
    unRead: '1',
  ),
  Chat(
    imageUrl: 'images/CurrentUser.jpg',
    sender: johnDoe,
    lastMessage: 'Hey there! I\'m doing well.',
    time: '7:30 PM',
    unRead: '',
  ),
  Chat(
    imageUrl: 'images/John.jpg',
    sender: currentUser,
    lastMessage: 'Did you watch that new movie?',
    time: '8:15 PM',
    unRead: '2',
  ),
  Chat(
    imageUrl: 'images/CurrentUser.jpg',
    sender: johnDoe,
    lastMessage: 'Yes, it was great! Highly recommend.',
    time: '9:00 PM',
    unRead: '',
  ),
  Chat(
    imageUrl: 'images/John.jpg',
    sender: currentUser,
    lastMessage: 'Awesome! I\'ll check it out.',
    time: '9:30 PM',
    unRead: '1',
  ),
  Chat(
    imageUrl: 'images/CurrentUser.jpg',
    sender: johnDoe,
    lastMessage: 'Let me know what you think after watching.',
    time: '10:00 PM',
    unRead: '',
  ),
];

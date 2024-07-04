class CUser {
  final int id;
  final String name;
  final String imageUrl;

  CUser({
    required this.id,
    required this.imageUrl,
    required this.name,
  });
}

final CUser currentUser = CUser(
  id: 0,
  name: 'Current User',
  imageUrl: 'images/John.jpg',
);

final CUser admin = CUser(
  id: 9,
  name: 'Call Center',
  imageUrl: 'images/Phone.ppg',
);

final CUser johnDoe = CUser(
  id: 1,
  name: 'John Doe',
  imageUrl: 'images/John.jpg',
);

final CUser sarahJones = CUser(
  id: 2,
  name: 'Sarah Jones',
  imageUrl: 'images/Sarah.jpg',
);

final CUser emilySmith = CUser(
  id: 3,
  name: 'Emily Smith',
  imageUrl: 'images/Emily.jpg',
);

final CUser michaelBrown = CUser(
  id: 4,
  name: 'Michael Brown',
  imageUrl: 'images/Michael.jpg',
);

final CUser lindaWilliams = CUser(
  id: 5,
  name: 'Linda Williams',
  imageUrl: 'images/William.jpg',
);

final CUser davidMiller = CUser(
  id: 6,
  name: 'David Miller',
  imageUrl: 'images/David.jpg',
);

final CUser oliviaWilson = CUser(
  id: 7,
  name: 'Olivia Wilson',
  imageUrl: 'images/Olivia.jpg',
);

final CUser avaAnderson = CUser(
  id: 8,
  name: "Ava Andaers",
  imageUrl: "images/Ava.jpg",
);

final List<CUser> favorites = [
  johnDoe,
  sarahJones,
  emilySmith,
  michaelBrown,
  lindaWilliams,
  davidMiller,
  oliviaWilson
];

final List<CUser> subscriptions = [
  johnDoe,
  sarahJones,
  emilySmith,
  michaelBrown,
  lindaWilliams,
  davidMiller,
  oliviaWilson
];


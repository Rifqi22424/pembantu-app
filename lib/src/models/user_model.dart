class User {
  final String type;
  final int id;
  final String name;
  final int age;
  final int experience;
  final String description;
  final String imageUrl;
  final String price;
  final String star;
  bool isLiked;

  final String noHp;
  final String gmail;

  final String tempatTinggal;
  final String agama;
  final List<String> keahlian;

  User(
      {required this.type,
      required this.id,
      required this.name,
      required this.age,
      required this.experience,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.star,
      required this.isLiked,
      required this.noHp,
      required this.gmail,
      required this.tempatTinggal,
      required this.agama,
      required this.keahlian});
}

final User johnDoe = User(
  type: 'ART',
  id: 1,
  name: 'John Doe',
  star: '5,4',
  age: 23,
  experience: 18,
  description:
      'John Doe adalah seorang profesional berpengalaman dalam bidang keamanan dengan 18 tahun pengalaman. Ia memiliki keahlian dalam mengatur keamanan dan memastikan lingkungan aman dan terkendali. Dengan harga sebesar 7.920.000, John siap memberikan pelayanan terbaik untuk keamanan Anda.',
  imageUrl: 'images/John.jpg',
  price: '2.500.000',
  isLiked: false,
  noHp: '+6285721050709',
  gmail: 'johndoe@gmail.com',
  tempatTinggal: 'Cibadak-Kab.Sukabumi, Jawa Barat',
  agama: 'Islam',
  keahlian: ['Driver', 'Baby Sister', 'ART', 'Pembantu Rumah Tangga'],
);

final User sarahJones = User(
  type: 'Supir',
  id: 2,
  name: 'Sarah Jones',
  star: '5,4',
  age: 32,
  experience: 12,
  description:
      'Sarah Jones adalah seorang pengasuh berbakat dengan 12 tahun pengalaman merawat anak-anak. Ia memiliki pemahaman yang mendalam tentang kebutuhan anak-anak dan mampu menciptakan lingkungan yang hangat dan mendukung perkembangan anak. Dengan harga sebesar 5.190.000, Sarah siap membantu Anda dalam merawat buah hati Anda.',
  imageUrl: 'images/Sarah.jpg',
  price: '1.500.000',
  isLiked: false,
  noHp: '+6285721050709',
  gmail: 'johndoe@gmail.com',
  tempatTinggal: 'Cibadak-Kab.Sukabumi, Jawa Barat',
  agama: 'Islam',
  keahlian: ['Driver', 'Baby Sister', 'ART', 'Pembantu Rumah Tangga'],
);

final User emilySmith = User(
  type: 'Satpam',
  id: 3,
  name: 'Emily Smith',
  star: '5,4',
  age: 28,
  experience: 15,
  description:
      'Emily Smith adalah seorang satpam berpengalaman dengan 15 tahun pengalaman dalam menjaga keamanan dan ketertiban. Ia memiliki keterampilan komunikasi yang baik dan mampu merespon situasi darurat dengan cepat. Dengan harga sebesar 9.450.000, Emily siap menjaga lingkungan Anda.',
  imageUrl: 'images/Emily.jpg',
  price: '2.500.000',
  isLiked: false,
  noHp: '+6285721050709',
  gmail: 'johndoe@gmail.com',
  tempatTinggal: 'Cibadak-Kab.Sukabumi, Jawa Barat',
  agama: 'Islam',
  keahlian: ['Driver', 'Baby Sister', 'ART', 'Pembantu Rumah Tangga'],
);

final User michaelBrown = User(
  type: 'Baby Sister',
  id: 4,
  name: 'Michael Brown',
  star: '5,4',
  age: 26,
  experience: 8,
  description:
      'Michael Brown adalah seorang pengasuh bayi yang berdedikasi dengan 8 tahun pengalaman merawat bayi dan balita. Ia memiliki perhatian penuh terhadap kebutuhan bayi dan mampu memberikan perawatan yang penuh kasih. Dengan harga sebesar 4.360.000, Michael siap membantu Anda merawat buah hati kecil Anda.',
  imageUrl: 'images/Michael.jpg',
  price: '3.000.000',
  isLiked: false,
  noHp: '+6285721050709',
  gmail: 'johndoe@gmail.com',
  tempatTinggal: 'Cibadak-Kab.Sukabumi, Jawa Barat',
  agama: 'Islam',
  keahlian: ['Driver', 'Baby Sister', 'ART', 'Pembantu Rumah Tangga'],
);

final User lindaWilliams = User(
  type: 'PRT',
  id: 5,
  name: 'Linda Williams',
  star: '5,4',
  age: 38,
  experience: 20,
  description:
      'Linda Williams adalah seorang pembantu rumah tangga berpengalaman dengan 20 tahun pengalaman dalam memberikan pelayanan rumah tangga. Ia ahli dalam melakukan berbagai tugas rumah tangga dan siap membantu Anda menjaga kebersihan dan kenyamanan rumah Anda. Dengan harga sebesar 6.900.000, Linda siap memberikan pelayanan terbaik untuk kebutuhan rumah tangga Anda.',
  imageUrl: 'images/William.jpg',
  price: '3.500.000',
  isLiked: false,
  noHp: '+6285721050709',
  gmail: 'johndoe@gmail.com',
  tempatTinggal: 'Cibadak-Kab.Sukabumi, Jawa Barat',
  agama: 'Islam',
  keahlian: ['Driver', 'Baby Sister', 'ART', 'Pembantu Rumah Tangga'],
);

final User davidMiller = User(
  type: 'PRT',
  id: 6,
  name: 'David Miller',
  star: '5,4',
  age: 35,
  experience: 18,
  description:
      'David Miller adalah seorang pembantu rumah tangga berpengalaman dengan 18 tahun pengalaman dalam memberikan pelayanan rumah tangga. Ia memiliki keahlian dalam merawat rumah dan menjaga kebersihan dengan teliti. Dengan harga sebesar 6.700.000, David siap membantu Anda menjaga kenyamanan rumah Anda.',
  imageUrl: 'images/David.jpg',
  price: '9.000.000',
  isLiked: false,
  noHp: '+6285721050709',
  gmail: 'johndoe@gmail.com',
  tempatTinggal: 'Cibadak-Kab.Sukabumi, Jawa Barat',
  agama: 'Islam',
  keahlian: ['Driver', 'Baby Sister', 'ART', 'Pembantu Rumah Tangga'],
);

final User oliviaWilson = User(
  type: 'Baby Sister',
  id: 7,
  name: 'Olivia Wilson',
  star: '5,4',
  age: 24,
  experience: 6,
  description:
      'Olivia Wilson adalah seorang pengasuh bayi yang penuh perhatian dengan 6 tahun pengalaman merawat bayi dan balita. Ia memiliki keterampilan dalam menjaga dan menghibur bayi serta pemahaman tentang perkembangan anak-anak. Dengan harga sebesar 4.180.000, Olivia siap membantu Anda merawat buah hati kecil Anda.',
  imageUrl: 'images/Olivia.jpg',
  price: '2.000.000',
  isLiked: false,
  noHp: '+6285721050709',
  gmail: 'johndoe@gmail.com',
  tempatTinggal: 'Cibadak-Kab.Sukabumi, Jawa Barat',
  agama: 'Islam',
  keahlian: ['Driver', 'Baby Sister', 'ART', 'Pembantu Rumah Tangga'],
);

final User avaAnderson = User(
  type: 'PRT',
  id: 8,
  name: "Ava Andaers",
  star: '5,4',
  age: 29,
  experience: 5,
  description:
      'Ava Anderson adalah seorang koki profesional dengan 5 tahun pengalaman. Ia memiliki kemampuan dalam memasak berbagai hidangan lezat dari berbagai masakan internasional. Dengan harga sebesar 4.250.000, Ava siap menghidangkan hidangan lezat untuk acara khusus atau sehari-hari.',
  imageUrl: "images/Ava.jpg",
  price: '3.000.000',
  isLiked: false,
  noHp: '+6285721050709',
  gmail: 'johndoe@gmail.com',
  tempatTinggal: 'Cibadak-Kab.Sukabumi, Jawa Barat',
  agama: 'Islam',
  keahlian: ['Driver', 'Baby Sister', 'ART', 'Pembantu Rumah Tangga'],
);

final List<User> userList = [
  johnDoe,
  sarahJones,
  emilySmith,
  michaelBrown,
  lindaWilliams,
  davidMiller,
  oliviaWilson,
  avaAnderson,
];

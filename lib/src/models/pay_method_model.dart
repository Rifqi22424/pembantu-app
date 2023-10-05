// ignore_for_file: non_constant_identifier_names

class Method {
  int selectedIndex;
  final String imageUrl;
  final String nameBank;
  bool isSelected;

  Method({
    required this.selectedIndex,
    required this.imageUrl,
    required this.nameBank,
    required this.isSelected,
  });
}

final Method BRI = Method(
  selectedIndex: 1,
  imageUrl: 'images/BRILogo.png',
  nameBank: 'BRI',
  isSelected: false,
);

final Method BCA = Method(
  selectedIndex: 2,
  imageUrl: 'images/BCALogo.png',
  nameBank: 'BCA',
  isSelected: false,
);

final Method Mandiri = Method(
  selectedIndex: 3,
  imageUrl: 'images/MandiriLogo.png',
  nameBank: 'Mandiri',
  isSelected: false,
);

final Method BNI = Method(
  selectedIndex: 4,
  imageUrl: 'images/BNILogo.png',
  nameBank: 'BNI',
  isSelected: false,
);

final List<Method> methodList = [
  BRI,
  BCA,
  Mandiri,
  BNI,
];

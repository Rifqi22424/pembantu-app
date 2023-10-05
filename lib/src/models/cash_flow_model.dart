class Cash {
  final String titleflow;
  final String date;
  final String detailCash;
  final bool payOrBuy;

  Cash({required this.titleflow, required this.date, required this.detailCash, required this.payOrBuy});
}

final Cash johnDoe = Cash(
  titleflow: 'John',
  date: '20 May, 2022',
  detailCash: '2.000.000',
  payOrBuy: true,
);

final Cash sarahJones = Cash(
  titleflow: 'Sarah',
  date: '20 Aug, 2022',
  detailCash: '2.500.000',
  payOrBuy: true,
);

final Cash emilySmith = Cash(
  titleflow: 'Emily',
  date: '3 June, 2020',
  detailCash: '2.000.000',
  payOrBuy: false,
);

final Cash michaelBrown = Cash(
  titleflow: 'Michael',
  date: '2 July, 2022',
  detailCash: '500.000',
  payOrBuy: false,
);

final Cash lindaWilliams = Cash(
  titleflow: 'Linda',
  date: '20 Sept, 2022',
  detailCash: '50.000',
  payOrBuy: false,
);

final List<Cash> cashList = [
  johnDoe,
  sarahJones,
  emilySmith,
  michaelBrown,
  lindaWilliams,
];

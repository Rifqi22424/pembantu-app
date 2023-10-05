class InterviewFree {
  final DateTime date;
  final int day;
  final String month;


  InterviewFree({
    required this.date,
    required this.day,
    required this.month,
  });
}

List<InterviewFree> generateInterviewFreeList() {
  final now = DateTime.now();
  final interviewFreeList = <InterviewFree>[];
  final currentMonth = now.month;
  

  for (var i = 0; i < 6; i++) {
    final currentDate = now.add(Duration(days: i));
    final day = currentDate.day;
    final month = _getMonthName(currentMonth);

    interviewFreeList.add(
      InterviewFree(
        date: currentDate,
        day: day,
        month: month,
      ),
    );
  }

  return interviewFreeList;
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}

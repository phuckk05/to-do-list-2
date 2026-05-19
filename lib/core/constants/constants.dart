import 'package:intl/intl.dart';

class Constants {
  //danh sách thứ viết tắt trong tuần
  static const List<String> daysOfWeek = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  //lấy danh sách ngày của tháng hiện tại
  static List<Map<String, String>> getDaysOfCurrentMonth(DateTime? date) {
    final now = date ?? DateTime.now();

    // số ngày trong tháng
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    List<Map<String, String>> result = [];

    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(now.year, now.month, i);

      final dayName = DateFormat('EEE').format(date); // Thứ
      final dayNumber = date.day.toString();

      result.add({'day': dayName, 'date': dayNumber});
    }
    return result;
  }

  //lấy ngày tháng năm hiện tại
  static String getCurrentDate(DateTime? date) {
    final now = date ?? DateTime.now();
    return DateFormat('EEEE, M/d/y').format(now);
  }

  static int getNumberOfDaysInMonth() {
    return DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
  }
}

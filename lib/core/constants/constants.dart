import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';

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

  static TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  //message khi tạo task thành công
  static ScaffoldMessengerState showSuccessMessage({
    required BuildContext context,
    required String message,
    Color? color,
    Color? backgroundColor,
  }) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          content: Center(
            child: Text(
              message,
              style: AppStyles.labelTaskStyle.copyWith(
                color: color ?? AppColors.neutralColor,
              ),
            ),
          ),
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
        ),
      );
  }
}

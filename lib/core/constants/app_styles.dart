import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/core/constants/app_colors.dart';

class AppStyles {
  //style cho text thứ trong tuần
  static final TextStyle dayOfWeekStyle = GoogleFonts.inter(
    color: AppColors.neutralColor,
    fontWeight: .normal,
    fontSize: 14,
  );
  //style cho text ngày trong tuần
  static final TextStyle dateOfWeekStyle = GoogleFonts.inter(
    color: AppColors.neutralColor,
    fontWeight: .bold,
    fontSize: 18,
  );
  //style cho text tiêu đề trong phần progress
  static final TextStyle progressTitleStyle = GoogleFonts.inter(
    color: AppColors.neutralColor,
    fontWeight: .normal,
    fontSize: 12,
  );
  //style cho text số task đã hoàn thành trong phần progress
  static final TextStyle progressTaskStyle = GoogleFonts.inter(
    color: AppColors.neutralColor,
    fontWeight: .w600,
    fontSize: 18,
  );
  //style cho text thời gian trong phần task
  static final TextStyle timeTaskStyle = GoogleFonts.inter(
    color: AppColors.progressColor,
    fontWeight: .normal,
    fontSize: 12,
  );
}

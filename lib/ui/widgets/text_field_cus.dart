import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';

/* Tự định nghĩa 1 text field 
  - controller: bộ điều khiển của text field
  - hintText: nội dung gợi ý trong text field
  - labelText: nội dung tiêu đề của text field
  - obscureText: ẩn nội dung trong text field
  - maxLength: độ dài tối đa của nội dung trong text field
  - maxLines: số dòng tối đa của nội dung trong text field
  - minLines: số dòng tối thiểu của nội dung trong text field
*/

class TextFieldCus extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController? controller;
  final String hintText;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextInputType? textInputType;
  final Color? textColor;
  final double? borderRadius;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool? ignorePointer;
  final VoidCallback? onTap;
  final bool? expands;
  const TextFieldCus({
    super.key,
    required this.width,
    required this.height,
    this.controller,
    required this.hintText,
    this.obscureText,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.textInputType,
    this.textColor,
    this.borderRadius,
    this.suffixIcon,
    this.prefixIcon,
    this.ignorePointer,
    this.onTap,
    this.expands,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      child: SizedBox(
        width: width,
        height: height,
        child: TextField(
          expands: expands ?? false,
          ignorePointers: ignorePointer ?? false,
          controller: controller,
          obscureText: obscureText ?? false,
          maxLength: maxLength,
          maxLines: expands != null ? null : maxLines ?? 1,
          minLines: expands != null ? null : minLines ?? 1,
          keyboardType: textInputType,
          style: AppStyles.labelTaskStyle.copyWith(
            color: textColor ?? AppColors.progressColor,
          ),

          decoration: InputDecoration(
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
              borderSide: BorderSide(color: AppColors.progressColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
              borderSide: BorderSide(color: AppColors.progressColor),
            ),
            hintStyle: AppStyles.labelTaskStyle.copyWith(
              color: (textColor ?? AppColors.progressColor).withOpacity(0.5),
              fontWeight: FontWeight.bold,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: Colors.red)
                : null,
          ),
        ),
      ),
    );
  }
}

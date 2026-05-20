import 'package:flutter/material.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';
import 'package:to_do_list/ui/widgets/loading_internal.dart';

/* Tự định nghĩa 1 button
  
  - text: nội dung hiển thị trên button
  - onPressed: hàm được gọi khi button được nhấn
  - backgroundColor: màu nền của button
  - textColor: màu chữ của button

*/

class ButtonCus extends StatelessWidget {
  final bool isLoading;
  final double? width;
  final double? height;
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const ButtonCus({
    super.key,
    required this.isLoading,
    required this.text,
    required this.width,
    required this.height,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    required TextStyle textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button: $text',
      child: SizedBox(
        height: height ?? 50,
        width: width ?? double.infinity,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppColors.greyColor,
            backgroundColor: backgroundColor ?? AppColors.primaryColor,
            foregroundColor: textColor ?? AppColors.neutralColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading == true
              ? LoadingInternal(
                  color: AppColors.neutralColor,
                  loading: isLoading,
                )
              : Text(
                  text,
                  style: AppStyles.labelTaskStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor ?? AppColors.neutralColor,
                  ),
                ),
        ),
      ),
    );
  }
}

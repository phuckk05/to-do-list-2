import 'package:flutter/material.dart';
import 'package:to_do_list/core/constants/app_colors.dart';

class CheckboxCus extends StatelessWidget {
  final VoidCallback? onChanged;
  final bool? checked;
  const CheckboxCus({super.key, this.onChanged, this.checked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: checked == true
            ? Icon(Icons.check, color: AppColors.primaryColor)
            : Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.greyColor, width: 1),
                ),
              ),
        onPressed: onChanged,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:to_do_list/core/constants/app_styles.dart';
import 'package:to_do_list/ui/widgets/checkbox_cus.dart';

import '../../core/constants/app_colors.dart';

class CheckboxDone extends StatelessWidget {
  final VoidCallback? onChanged;
  final bool? checked;
  const CheckboxDone({super.key, this.onChanged, this.checked});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.progressColor.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            CheckboxCus(onChanged: onChanged, checked: checked),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mark as Complete',
                  style: AppStyles.labelTaskStyle.copyWith(fontSize: 20),
                ),
                Text(
                  'Currently In Progress',
                  style: AppStyles.labelTaskStyle.copyWith(
                    fontSize: 12,
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

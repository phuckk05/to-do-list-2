import 'package:flutter/material.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';

class TasksDoneCus extends StatelessWidget {
  const TasksDoneCus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: .max,
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            Text(
              'YOUR PROGRESS',
              textAlign: TextAlign.center,
              style: AppStyles.progressTitleStyle,
            ),
            //số task đã hoàn thành
            Text(
              '1 of 3 Tasks Done',
              textAlign: TextAlign.center,
              style: AppStyles.progressTaskStyle,
            ),
            Spacer(flex: 1),
            //thanh progress
            Container(
              height: 10,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.progressColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 1 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.neutralColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

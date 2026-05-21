import 'package:flutter/material.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';

import '../models/task.dart';

class TasksDoneCus extends StatelessWidget {
  final List<Task> tasks;
  const TasksDoneCus({super.key, required this.tasks});

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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOUR PROGRESS',
              textAlign: TextAlign.center,
              style: AppStyles.progressTitleStyle,
            ),
            //số task đã hoàn thành
            Text(
              '${tasks.where((task) => task.status == TaskStatus.completed).length} of ${tasks.length} Tasks Done',
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
                  widthFactor: tasks.isNotEmpty
                      ? tasks
                                .where(
                                  (task) => task.status == TaskStatus.completed,
                                )
                                .length /
                            tasks.length
                      : 0,
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

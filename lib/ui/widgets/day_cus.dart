import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';
import 'package:to_do_list/ui/cubits/select_day_cubit.dart';

class DayCus extends StatelessWidget {
  final String day;
  final int date;
  final VoidCallback? onTap;
  const DayCus({super.key, required this.day, required this.date, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectDayCubit, int>(
      builder: (context, selectedDay) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 0,
            top: 12,
            bottom: 12,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: selectedDay == date
                    ? AppColors.primaryColor
                    : AppColors.neutralColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: AppStyles.dayOfWeekStyle.copyWith(
                      color: selectedDay == date
                          ? AppColors.neutralColor
                          : AppColors.progressColor,
                    ),
                  ),
                  Text(
                    date.toString(),
                    style: AppStyles.dateOfWeekStyle.copyWith(
                      color: selectedDay == date
                          ? AppColors.neutralColor
                          : AppColors.progressColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

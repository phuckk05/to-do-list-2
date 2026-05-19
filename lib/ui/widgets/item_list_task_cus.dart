import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';
import 'package:to_do_list/ui/cubits/checkbox_cubit.dart';
import 'package:to_do_list/ui/widgets/checkbox_cus.dart';

class ItemListTaskCus extends StatelessWidget {
  const ItemListTaskCus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          color: AppColors.neutralColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primaryColor, width: 1),
        ),
        child: Row(
          children: [
            SizedBox(width: 12),
            CheckboxCus(),
            SizedBox(width: 12),
            Expanded(
              child: BlocBuilder<CheckboxCubit, bool>(
                builder: (context, isChecked) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTime(isChecked),
                      _buildTaskTitle(isChecked),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //text time
  Widget _buildTime(bool isChecked) {
    return Text(
      '08:00 - 10:00',
      style: GoogleFonts.inter(
        color: isChecked
            ? AppColors.greyColor.withOpacity(0.5)
            : AppColors.primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        decoration: isChecked ? TextDecoration.lineThrough : null,
      ),
    );
  }

  //text task title
  Widget _buildTaskTitle(bool isChecked) {
    return Text(
      'Task Titlesajfffffffffffffffffffffffffffffffffffffffffffffh',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppStyles.progressTaskStyle.copyWith(
        color: isChecked ? AppColors.greyColor.withOpacity(0.5) : Colors.black,
        decoration: isChecked ? TextDecoration.lineThrough : null,
      ),
    );
  }
}

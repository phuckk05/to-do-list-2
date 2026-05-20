import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/ui/cubits/checkbox_cubit.dart';

class CheckboxCus extends StatelessWidget {
  const CheckboxCus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckboxCubit, bool>(
      builder: (context, state) {
        return SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: state
                ? Icon(Icons.check, color: AppColors.primaryColor)
                : Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.greyColor, width: 1),
                    ),
                  ),
            onPressed: () => context.read<CheckboxCubit>().toggle(),
          ),
        );
      },
    );
  }
}

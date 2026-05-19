import 'package:flutter/material.dart';
import 'package:to_do_list/core/constants/app_styles.dart';

class LabelCus extends StatelessWidget {
  final String text;
  const LabelCus({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: AppStyles.labelTaskStyle),
    );
  }
}

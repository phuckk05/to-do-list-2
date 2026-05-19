import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';
import 'package:to_do_list/core/constants/constants.dart';
import 'package:to_do_list/ui/cubits/loading_global_cubit.dart';
import 'package:to_do_list/ui/cubits/loading_internal_cubit.dart';
import 'package:to_do_list/ui/widgets/button_cus.dart';
import 'package:to_do_list/ui/widgets/label_cus.dart';
import 'package:to_do_list/ui/widgets/loading_internal.dart';
import 'package:to_do_list/ui/widgets/text_field_cus.dart';

class NewTaskScreen extends StatelessWidget {
  NewTaskScreen({super.key});

  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDateController = TextEditingController(
    text: Constants.getCurrentDate(DateTime.now()),
  );
  final TextEditingController _taskStartTimeController =
      TextEditingController();
  final TextEditingController _taskEndTimeController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  void _onbackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onDateFieldTapped(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _taskDateController.text = Constants.getCurrentDate(picked);
    }
  }

  void _onTimeFieldTapped(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;
    controller.text =
        picked.hour.toString().padLeft(2, '0') +
        ':' +
        picked.minute.toString().padLeft(2, '0');
  }

  //oncreate
  void _onCreateTaskPressed(BuildContext context) async {
    context.read<LoadingInternalCubit>().setLoading(true);
    await Future.delayed(Duration(seconds: 10));
    context.read<LoadingInternalCubit>().setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 56,
              floating: true,
              snap: true,
              elevation: 0,
              title: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'New Task',
                    style: AppStyles.timeTaskStyle.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Constants.getCurrentDate(DateTime.now()),
                    style: AppStyles.timeTaskStyle,
                  ),
                ],
              ),

              actions: [
                IconButton(
                  onPressed: () => _onbackPressed(context),
                  icon: Icon(Icons.close, color: AppColors.progressColor),
                ),
              ],
            ),

            //title
            SliverPadding(
              padding: EdgeInsets.only(left: 16, top: 12, right: 12),
              sliver: SliverToBoxAdapter(child: LabelCus(text: 'Task Title')),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 16, top: 12, right: 12),
              sliver: SliverToBoxAdapter(
                child: TextFieldCus(
                  width: double.infinity,
                  height: 50,
                  hintText: 'Enter task title',
                  controller: _taskTitleController,
                ),
              ),
            ),

            //date
            SliverPadding(
              padding: EdgeInsets.only(left: 16, top: 12, right: 12),
              sliver: SliverToBoxAdapter(child: LabelCus(text: 'Date')),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 16, top: 12, right: 12),
              sliver: SliverToBoxAdapter(
                child: TextFieldCus(
                  width: double.infinity,
                  height: 50,
                  hintText: 'Enter task date',
                  controller: _taskDateController,
                  ignorePointer: true,
                  prefixIcon: Icons.calendar_today,
                  onTap: () => _onDateFieldTapped(context),
                ),
              ),
            ),
            //time range
            SliverPadding(
              padding: EdgeInsets.only(left: 16, top: 12, right: 12),
              sliver: SliverToBoxAdapter(child: LabelCus(text: 'Time Range')),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 16, top: 12, right: 12),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldCus(
                          width: double.infinity,
                          height: 50,
                          hintText: 'Start Time',
                          prefixIcon: Icons.access_time,
                          controller: _taskStartTimeController,
                          ignorePointer: true,
                          onTap: () => _onTimeFieldTapped(
                            context,
                            _taskStartTimeController,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextFieldCus(
                          width: double.infinity,
                          height: 50,
                          hintText: 'End Time',
                          prefixIcon: Icons.access_time,
                          controller: _taskEndTimeController,
                          ignorePointer: true,
                          onTap: () => _onTimeFieldTapped(
                            context,
                            _taskEndTimeController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 16, top: 12, right: 12),
              sliver: SliverToBoxAdapter(child: LabelCus(text: 'Description')),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 16, top: 12, right: 12),
              sliver: SliverToBoxAdapter(
                child: TextFieldCus(
                  width: double.infinity,
                  height: 150,
                  expands: true,
                  maxLines: 5,
                  minLines: 1,
                  hintText: 'Enter task description',
                  controller: _taskDescriptionController,
                ),
              ),
            ),
            BlocBuilder<LoadingInternalCubit, bool>(
              builder: (context, isLoading) {
                return SliverPadding(
                  padding: EdgeInsets.only(left: 16, top: 12, right: 12),
                  sliver: SliverToBoxAdapter(
                    child: ButtonCus(
                      onPressed: () {
                        _onCreateTaskPressed(context);
                      },
                      isLoading: isLoading,
                      text: 'Create Task',
                      width: double.infinity,
                      height: 50,
                      textStyle: AppStyles.labelTaskStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.neutralColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

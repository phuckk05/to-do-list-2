import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';
import 'package:to_do_list/core/constants/constants.dart';
import 'package:to_do_list/core/router/app_router_name.dart';
import 'package:to_do_list/ui/blocs/task/task_bloc.dart';
import 'package:to_do_list/ui/blocs/task/task_event.dart';
import 'package:to_do_list/ui/blocs/task/task_state.dart';
import 'package:to_do_list/ui/cubits/checkbox_cubit.dart';
import 'package:to_do_list/ui/models/task.dart';
import 'package:to_do_list/ui/widgets/button_cus.dart';
import 'package:to_do_list/ui/widgets/checkbox_done.dart';
import 'package:to_do_list/ui/widgets/label_cus.dart';
import 'package:to_do_list/ui/widgets/text_field_cus.dart';

class NewTaskScreen extends StatefulWidget {
  final Task? task;
  const NewTaskScreen({super.key, this.task});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  late TaskBloc _taskBloc;
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDateController = TextEditingController(
    text: Constants.getCurrentDate(DateTime.now()),
  );
  final TextEditingController _taskStartTimeController =
      TextEditingController();
  final TextEditingController _taskEndTimeController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskBloc = context.read<TaskBloc>();
    if (widget.task != null) {
      _taskTitleController.text = widget.task!.title;
      _taskDateController.text = widget.task!.date;
      _taskStartTimeController.text = widget.task!.startTime;
      _taskEndTimeController.text = widget.task!.endTime;
      _taskDescriptionController.text = widget.task!.description;
      context.read<CheckboxCubit>().setChecked(
        widget.task!.status == TaskStatus.completed,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _taskTitleController.dispose();
    _taskDateController.dispose();
    _taskStartTimeController.dispose();
    _taskEndTimeController.dispose();
    _taskDescriptionController.dispose();
  }

  void _clearForm() {
    _taskTitleController.clear();
    _taskDateController.text = Constants.getCurrentDate(DateTime.now());
    _taskStartTimeController.clear();
    _taskEndTimeController.clear();
    _taskDescriptionController.clear();
  }

  bool checkIsFormEmpty() {
    return _taskTitleController.text.isNotEmpty &&
        _taskDateController.text.isNotEmpty &&
        _taskStartTimeController.text.isNotEmpty &&
        _taskEndTimeController.text.isNotEmpty;
  }

  void _onChangedCheckbox() {
    context.read<CheckboxCubit>().toggle();
  }

  void _onbackPressed() {
    context.pop();
  }

  //check thời gian đã hợp lệ chưa
  bool _isTimeRangeValid() {
    if (_taskStartTimeController.text.isEmpty ||
        _taskEndTimeController.text.isEmpty) {
      return true; // Nếu chưa nhập thời gian, coi như hợp lệ
    }
    final startTime = Constants.parseTimeOfDay(_taskStartTimeController.text);
    final endTime = Constants.parseTimeOfDay(_taskEndTimeController.text);
    return startTime.hour < endTime.hour ||
        (startTime.hour == endTime.hour && startTime.minute < endTime.minute);
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
    if (!_isTimeRangeValid()) {
      Constants.showSuccessMessage(
        context: context,
        message: 'End time must be after start time.',
        color: AppColors.neutralColor,
        backgroundColor: AppColors.progressColor,
      );
      controller.clear();
      return;
    }
  }

  //oncreate
  void _onCreateTaskPressed() async {
    if (!checkIsFormEmpty()) {
      Constants.showSuccessMessage(
        context: context,
        message: 'Please fill in all required fields.',
        color: AppColors.neutralColor,
        backgroundColor: AppColors.progressColor,
      );
      return;
    }

    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _taskTitleController.text,
      date: _taskDateController.text,
      startTime: _taskStartTimeController.text,
      endTime: _taskEndTimeController.text,
      description: _taskDescriptionController.text,
      status: TaskStatus.pending,
    );

    _taskBloc.add(CreateTask(task));
  }

  void _onUpdateTaskPressed() async {
    if (!checkIsFormEmpty()) {
      Constants.showSuccessMessage(
        context: context,
        message: 'Please fill in all required fields.',
        color: AppColors.neutralColor,
        backgroundColor: AppColors.progressColor,
      );
      return;
    }
    if (widget.task == null) return;

    final updatedTask = widget.task!.copyWith(
      title: _taskTitleController.text,
      date: _taskDateController.text,
      startTime: _taskStartTimeController.text,
      endTime: _taskEndTimeController.text,
      description: _taskDescriptionController.text,
      status: context.read<CheckboxCubit>().state
          ? TaskStatus.completed
          : TaskStatus.pending,
    );

    _taskBloc.add(UpdateTask(updatedTask));
  }

  void _deleteTaskPressed() async {
    if (widget.task == null) return;

    _taskBloc.add(DeleteTask(widget.task!));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocListener<TaskBloc, TaskState>(
          listener: (context, state) async {
            if (state.status == StateStatus.success &&
                state.action == StateAction.creating) {
              _clearForm();
              Constants.showSuccessMessage(
                context: context,
                message: widget.task != null
                    ? 'Task updated successfully!'
                    : 'Task created successfully!',
                color: AppColors.neutralColor,
                backgroundColor: AppColors.progressColor,
              );
            }
            if (state.status == StateStatus.success &&
                state.action == StateAction.updating) {
              Constants.showSuccessMessage(
                context: context,
                message: 'Task updated successfully!',
                color: AppColors.neutralColor,
                backgroundColor: AppColors.progressColor,
              );
            }
            if (state.status == StateStatus.success &&
                state.action == StateAction.deleting) {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(AppRouterName.tasks);
              }
              Constants.showSuccessMessage(
                context: context,
                message: 'Task deleted successfully!',
                color: AppColors.neutralColor,
                backgroundColor: AppColors.progressColor,
              );
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 56,
                floating: true,
                snap: true,
                elevation: 0,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task != null ? 'Edit Task' : 'New Task',
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
                    onPressed: () => _onbackPressed(),
                    icon: Icon(Icons.close, color: AppColors.progressColor),
                  ),
                ],
              ),
              if (widget.task != null)
                SliverPadding(
                  padding: EdgeInsets.only(left: 16, top: 12, right: 16),
                  sliver: SliverToBoxAdapter(
                    child: CheckboxDone(
                      onChanged: _onChangedCheckbox,
                      checked: context.watch<CheckboxCubit>().state,
                    ),
                  ),
                ),

              //title
              SliverPadding(
                padding: EdgeInsets.only(left: 16, top: 12, right: 16),
                sliver: SliverToBoxAdapter(child: LabelCus(text: 'Task Title')),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 16, top: 12, right: 16),
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
                padding: EdgeInsets.only(left: 16, top: 12, right: 16),
                sliver: SliverToBoxAdapter(child: LabelCus(text: 'Date')),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 16, top: 12, right: 16),
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
                padding: EdgeInsets.only(left: 16, top: 12, right: 16),
                sliver: SliverToBoxAdapter(child: LabelCus(text: 'Time Range')),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 16, top: 12, right: 16),
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
                padding: EdgeInsets.only(left: 16, top: 12, right: 16),
                sliver: SliverToBoxAdapter(
                  child: LabelCus(text: 'Description'),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 16, top: 12, right: 16),
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
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  return SliverPadding(
                    padding: EdgeInsets.only(left: 16, top: 12, right: 16),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        if (widget.task != null) ...[
                          SliverToBoxAdapter(
                            child: ButtonCus(
                              onPressed: state.status == StateStatus.loading
                                  ? null
                                  : () => _deleteTaskPressed(),
                              isLoading:
                                  state.status == StateStatus.loading &&
                                  state.action == StateAction.deleting,
                              text: 'Delete Task',
                              width: double.infinity,
                              height: 50,
                              textStyle: AppStyles.labelTaskStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              backgroundColor: AppColors.neutralColor,
                              textColor: AppColors.tertiaryColor,
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 12)),
                        ],

                        // SliverToBoxAdapter(child: SizedBox(height: 12)),
                        SliverToBoxAdapter(
                          child: ButtonCus(
                            onPressed: state.status == StateStatus.loading
                                ? null
                                : () {
                                    widget.task != null
                                        ? _onUpdateTaskPressed()
                                        : _onCreateTaskPressed();
                                  },
                            isLoading:
                                state.status == StateStatus.loading &&
                                (state.action == StateAction.creating ||
                                    state.action == StateAction.updating),
                            text: widget.task != null
                                ? 'Save Task'
                                : 'Create Task',
                            width: double.infinity,
                            height: 50,
                            textStyle: AppStyles.labelTaskStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.neutralColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 16, top: 12, right: 16),
                sliver: SliverToBoxAdapter(child: SizedBox(height: 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

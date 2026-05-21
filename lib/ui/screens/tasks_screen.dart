import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';
import 'package:to_do_list/core/constants/constants.dart';
import 'package:to_do_list/core/router/app_router_name.dart';
import 'package:to_do_list/ui/blocs/task/task_state.dart';
import 'package:to_do_list/ui/cubits/datetime_now_cubit.dart';
import 'package:to_do_list/ui/cubits/select_day_cubit.dart';
import 'package:to_do_list/ui/models/task.dart';
import 'package:to_do_list/ui/widgets/day_cus.dart';
import 'package:to_do_list/ui/widgets/item_list_task_cus.dart';
import 'package:to_do_list/ui/widgets/loading_internal.dart';
import 'package:to_do_list/ui/widgets/tasks_done_cus.dart';

import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  //khai báo biến

  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    //lấy tất cả tasks
    context.read<TaskBloc>().add(LoadAllTasks());
    context.read<DatetimeNowCubit>().updateDate(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemScrollController.scrollTo(
        index: DateTime.now().day - 1,
        alignment: 0.5,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
    super.initState();
  }

  void _onTapChangeDay(int index, DateTime date) {
    itemScrollController.scrollTo(
      index: index,
      alignment: 0.4,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    context.read<SelectDayCubit>().selectDay(date);
  }

  void _onTapChangeDate() async {
    //mở date picker
    final DateTime? picked = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      context.read<DatetimeNowCubit>().updateDate(picked);
      //nếu cùng tháng
      if (DateTime.now().month != picked.month ||
          DateTime.now().year != picked.year) {
        print('Selected month: ${picked.month}, year: ${picked.year}');
        // context.read<SelectDayCubit>().selectDay(
        //   DateTime(picked.year, picked.month, 1, 0, 0, 0),
        // );
        _onTapChangeDay(0, DateTime(picked.year, picked.month, 1, 0, 0, 0));
      } else {
        _onTapChangeDay(
          DateTime.now().day - 1,
          DateTime(picked.year, picked.month, DateTime.now().day, 0, 0, 0),
        );
        // context.read<SelectDayCubit>().selectDay(
        //   DateTime(picked.year, picked.month, DateTime.now().day, 0, 0, 0),
        // );
      }
    }
  }

  void _onEditTask(Task task) {
    context.pushNamed(AppRouterName.editTask, extra: task);
  }

  void _onTapAddTask(BuildContext context) {
    this.context.pushNamed(AppRouterName.addTask);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.neutralColor,
            expandedHeight: 56,
            floating: true,
            snap: true,
            elevation: 0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To Day',
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
                onPressed: _onTapChangeDate,
                icon: Icon(Icons.date_range, color: AppColors.secondaryColor),
              ),
            ],
          ),
          //danh sách ngày
          BlocBuilder<DatetimeNowCubit, DateTime>(
            builder: (context, selecedDate) {
              return SliverPadding(
                padding: const EdgeInsets.only(top: 0),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 102,
                    child: ScrollablePositionedList.separated(
                      itemScrollController: itemScrollController,
                      separatorBuilder: (context, index) => SizedBox(width: 0),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final day = Constants.getDaysOfCurrentMonth(
                          selecedDate,
                        )[index]['day'];
                        final date = Constants.getDaysOfCurrentMonth(
                          selecedDate,
                        )[index]['date'];
                        return DayCus(
                          day: day ?? '',
                          date: int.tryParse(date ?? '0') ?? 0,
                          onTap: () => _onTapChangeDay(
                            index,
                            DateTime(
                              selecedDate.year,
                              selecedDate.month,
                              int.tryParse(date ?? '0') ?? 0,
                              0,
                              0,
                              0,
                            ),
                          ),
                        );
                      },
                      itemCount: Constants.getDaysOfCurrentMonth(
                        selecedDate,
                      ).length,
                    ),
                  ),
                ),
              );
            },
          ),
          //danh sách task đã hoàn thành
          //danh sách task
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return BlocBuilder<SelectDayCubit, DateTime>(
                builder: (context, selectedDate) {
                  final tasksOfSelectedDay =
                      state.task?.where((task) {
                              return task.date ==
                                  Constants.getCurrentDate(selectedDate);
                            }).toList() ??
                            []
                        ..sort((a, b) => a.startTime.compareTo(b.startTime));

                  if (state.status == StateStatus.loading &&
                      state.action == StateAction.getting) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                        child: LoadingInternal(
                          color: AppColors.progressColor,
                          loading: true,
                        ),
                      ),
                    );
                  }

                  return SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: TasksDoneCus(tasks: tasksOfSelectedDay),
                      ),

                      if (tasksOfSelectedDay.isNotEmpty) ...[
                        SliverPadding(
                          padding: const EdgeInsets.only(top: 12),
                          sliver: SliverList.separated(
                            itemCount: tasksOfSelectedDay.length,
                            itemBuilder: (context, index) {
                              return ItemListTaskCus(
                                task: tasksOfSelectedDay[index],
                                onTap: () =>
                                    _onEditTask(tasksOfSelectedDay[index]),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16),
                          ),
                        ),
                      ] else ...[
                        SliverPadding(
                          padding: const EdgeInsets.only(top: 32),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              'No tasks for this day',
                              style: AppStyles.labelTaskStyle.copyWith(
                                fontSize: 14,
                                color: AppColors.greyColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () => _onTapAddTask(context),
        child: Icon(Icons.add, color: AppColors.neutralColor),
      ),
    );
  }
}

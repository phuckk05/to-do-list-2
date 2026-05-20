import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';
import 'package:to_do_list/core/constants/constants.dart';
import 'package:to_do_list/ui/blocs/task/task_state.dart';
import 'package:to_do_list/ui/cubits/datetime_now_cubit.dart';
import 'package:to_do_list/ui/cubits/select_day_cubit.dart';
import 'package:to_do_list/ui/widgets/day_cus.dart';
import 'package:to_do_list/ui/widgets/item_list_task_cus.dart';
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

  void _onTapChangeDay(int index) {
    itemScrollController.scrollTo(
      index: index,
      alignment: 0.4,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    context.read<SelectDayCubit>().selectDay(
      DateTime.now().copyWith(day: index + 1),
    );
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
      //nếu cùng tháng
      if (DateTime.now().month != picked.month ||
          DateTime.now().year != picked.year) {
        print('Selected month: ${picked.month}, year: ${picked.year}');
        context.read<SelectDayCubit>().selectDay(
          DateTime(picked.year, picked.month, 1),
        );
        _onTapChangeDay(context.read<SelectDayCubit>().state.day - 1);
      } else {
        _onTapChangeDay(DateTime.now().day - 1);
        context.read<SelectDayCubit>().selectDay(
          DateTime(picked.year, picked.month, DateTime.now().day),
        );
      }
    }
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
                padding: const EdgeInsets.only(top: 12),
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
                          onTap: () => _onTapChangeDay(index),
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
          SliverToBoxAdapter(child: TasksDoneCus()),
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
                      [];

                  // print('Tasks of selected day: ${state.task!.first.date}');
                  print('Selected date: ${selectedDate}');
                  return SliverPadding(
                    padding: const EdgeInsets.only(top: 12),
                    sliver: SliverList.separated(
                      itemCount: tasksOfSelectedDay.length,
                      itemBuilder: (context, index) {
                        return ItemListTaskCus(task: tasksOfSelectedDay[index]);
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

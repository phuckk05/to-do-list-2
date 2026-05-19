import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:to_do_list/core/constants/app_colors.dart';
import 'package:to_do_list/core/constants/app_styles.dart';
import 'package:to_do_list/core/constants/constants.dart';
import 'package:to_do_list/ui/cubits/select_day_cubit.dart';
import 'package:to_do_list/ui/widgets/day_cus.dart';
import 'package:to_do_list/ui/widgets/item_list_task_cus.dart';
import 'package:to_do_list/ui/widgets/tasks_done_cus.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
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
    context.read<SelectDayCubit>().selectDay(index + 1);
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
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                Text(
                  'To Day',
                  style: AppStyles.timeTaskStyle.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tuesday, September 26, 2026',
                  style: AppStyles.timeTaskStyle,
                ),
              ],
            ),

            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.date_range, color: AppColors.secondaryColor),
              ),
            ],
          ),
          //danh sách ngày
          SliverPadding(
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
                    final day = Constants.getDaysOfCurrentMonth()[index]['day'];
                    final date =
                        Constants.getDaysOfCurrentMonth()[index]['date'];
                    return DayCus(
                      day: day ?? '',
                      date: int.tryParse(date ?? '0') ?? 0,
                      onTap: () => _onTapChangeDay(index),
                    );
                  },
                  itemCount: Constants.getDaysOfCurrentMonth().length,
                ),
              ),
            ),
          ),
          //danh sách task đã hoàn thành
          SliverToBoxAdapter(child: TasksDoneCus()),
          //danh sách task
          SliverPadding(
            padding: const EdgeInsets.only(top: 12),
            sliver: SliverList.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ItemListTaskCus();
              },
              separatorBuilder: (context, index) => SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }
}

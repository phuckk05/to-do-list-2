import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:to_do_list/core/router/app_router.dart';
import 'package:to_do_list/ui/blocs/task/task_bloc.dart';
import 'package:to_do_list/ui/cubits/checkbox_cubit.dart';
import 'package:to_do_list/ui/cubits/database_cubit.dart';
import 'package:to_do_list/ui/cubits/datetime_now_cubit.dart';
import 'package:to_do_list/ui/cubits/loading_global_cubit.dart';
import 'package:to_do_list/ui/cubits/loading_internal_cubit.dart';
import 'package:to_do_list/ui/cubits/select_day_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CheckboxCubit()),
        BlocProvider(create: (_) => SelectDayCubit()),
        BlocProvider(create: (_) => DatetimeNowCubit()),
        BlocProvider(create: (_) => LoadingGlobalCubit()),
        BlocProvider(create: (_) => LoadingInternalCubit()),
        BlocProvider(create: (_) => DatabaseCubit()),
        BlocProvider(create: (_) => TaskBloc()),
      ],
      child: const ToDoList(),
    ),
  );
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late final GoRouter _router;

  @override
  void initState() {
    context.read<DatabaseCubit>().initializeDatabase();
    _router = createRouter(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        MonthYearPickerLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('vi', '')],
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}

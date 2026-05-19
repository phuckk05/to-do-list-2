import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list/core/router/app_router.dart';
import 'package:to_do_list/ui/cubits/checkbox_cubit.dart';
import 'package:to_do_list/ui/cubits/select_day_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CheckboxCubit()),
        BlocProvider(create: (_) => SelectDayCubit()),
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
    _router = createRouter(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}

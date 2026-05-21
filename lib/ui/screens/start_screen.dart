import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list/core/router/app_router_name.dart';
import 'package:to_do_list/ui/blocs/task/task_bloc.dart';
import 'package:to_do_list/ui/blocs/task/task_state.dart';

import '../blocs/task/task_event.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(LoadAllTasks());
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state.status == StateStatus.success) {
          context.goNamed(AppRouterName.tasks);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/images/logo.png', width: 150, height: 150),
        ),
      ),
    );
  }
}

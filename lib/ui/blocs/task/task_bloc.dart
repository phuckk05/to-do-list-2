import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/ui/models/task.dart';
import 'package:to_do_list/ui/repositories/task_repository.dart';

import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository = TaskRepository();

  TaskBloc() : super(TaskState()) {
    on<LoadAllTasks>((event, emit) async {
      //xử lý logic lấy tất cả task
      emit(
        state.copyWith(
          action: StateAction.getting,
          status: StateStatus.loading,
        ),
      );
      // await Future.delayed(const Duration(seconds: 2));
      await emit.forEach<List<Task>>(
        taskRepository.getAll(),
        onData: (tasks) {
          return state.copyWith(status: StateStatus.success, task: tasks);
        },
        onError: (_, __) {
          return state.copyWith(status: StateStatus.failure);
        },
      );
    });
    on<LoadTasksByDate>((event, emit) {
      //xử lý logic lấy task theo ngày
    });
    on<CreateTask>((event, emit) async {
      //tạo loading
      try {
        emit(
          state.copyWith(
            action: StateAction.creating,
            status: StateStatus.loading,
          ),
        );

        await Future.delayed(const Duration(seconds: 2));

        await taskRepository.createTask(event.task);
        emit(state.copyWith(status: StateStatus.success));
      } catch (e) {
        if (emit.isDone) return;
        emit(state.copyWith(status: StateStatus.failure));
      }
    });
    on<DeleteTask>((event, emit) async {
      try {
        emit(
          state.copyWith(
            action: StateAction.deleting,
            status: StateStatus.loading,
          ),
        );

        await Future.delayed(const Duration(seconds: 2));

        await taskRepository.delateTask(event.task);
        emit(state.copyWith(status: StateStatus.success));
      } catch (e) {
        if (emit.isDone) return;
        emit(state.copyWith(status: StateStatus.failure));
      }
    });
    //update task
    on<UpdateTask>((event, emit) async {
      try {
        emit(
          state.copyWith(
            action: StateAction.updating,
            status: StateStatus.loading,
          ),
        );

        await Future.delayed(const Duration(seconds: 5));

        await taskRepository.updateTask(event.task);
        emit(state.copyWith(status: StateStatus.success));
      } catch (e) {
        if (emit.isDone) return;
        emit(state.copyWith(status: StateStatus.failure));
      }
    });
  }
}

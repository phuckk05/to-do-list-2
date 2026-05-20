import 'package:to_do_list/ui/models/task.dart';

enum StateStatus { initial, loading, success, failure }

class TaskState {
  final List<Task>? task;
  final StateStatus status;
  TaskState({this.task, this.status = StateStatus.initial});

  TaskState copyWith({List<Task>? task, StateStatus? status}) {
    return TaskState(task: task ?? this.task, status: status ?? this.status);
  }
}

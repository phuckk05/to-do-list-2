import 'package:to_do_list/ui/models/task.dart';

enum StateAction { initial, getting, creating, updating, deleting }

enum StateStatus { initial, loading, success, failure }

class TaskState {
  final List<Task>? task;
  final StateAction action;
  final StateStatus status;
  TaskState({
    this.task,
    this.action = StateAction.initial,
    this.status = StateStatus.initial,
  });

  TaskState copyWith({
    List<Task>? task,
    StateAction? action,
    StateStatus? status,
  }) {
    return TaskState(
      task: task ?? this.task,
      action: action ?? this.action,
      status: status ?? this.status,
    );
  }
}

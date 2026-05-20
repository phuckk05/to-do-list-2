//định nghĩa các event của task
import 'package:to_do_list/ui/models/task.dart';

abstract class TaskEvent {}

//lấy tất cả task
class LoadAllTasks extends TaskEvent {}

//crate task
class CreateTask extends TaskEvent {
  final Task task;
  CreateTask(this.task);
}

//Lấy danh sách task theo ngày
class LoadTasksByDate extends TaskEvent {
  final String date;
  LoadTasksByDate(this.date);
}

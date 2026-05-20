import 'package:floor/floor.dart';
import 'package:to_do_list/ui/models/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Stream<List<Task>> getAllTask();

  @Query('SELECT * FROM Task WHERE date = :date')
  Stream<List<Task>> getAllTasks(String date);

  @insert
  Future<void> insertTask(Task task);

  @update
  Future<void> updateTask(Task task);

  @delete
  Future<void> deleteTask(Task task);
}

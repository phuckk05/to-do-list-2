import 'package:to_do_list/ui/models/task.dart';
import 'package:to_do_list/ui/services/task_dao/app_data_base.dart';

class TaskRepository {
  final _database = $FloorAppDataBase
      .databaseBuilder('app_database.db')
      .build();

  //create
  Future<void> createTask(Task task) =>
      _database.then((value) => value.taskDao.insertTask(task));
  //getall
  Stream<List<Task>> getAll() {
    return _database.asStream().asyncExpand(
      (value) => value.taskDao.getAllTask(),
    );
  }

  //get task theo date
  //   Future<List<Task>> getAllByDate(String date) => taskDao.getAllTasks(date);
  //dalete
  //   Future<void> delateTask(Task task) => taskDao.deleteTask(task);
  //update
  //   Future<void> updateTask(Task task) => taskDao.updateTask(task);
}

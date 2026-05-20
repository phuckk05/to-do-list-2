import 'dart:async';

import 'package:floor/floor.dart';
import 'package:to_do_list/ui/models/task.dart';
import 'package:to_do_list/ui/services/task_dao/task_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_data_base.g.dart';

@Database(version: 1, entities: [Task])
abstract class AppDataBase extends FloorDatabase {
  TaskDao get taskDao;
}

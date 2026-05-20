import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/ui/services/task_dao/app_data_base.dart';

class DatabaseCubit extends Cubit<AppDataBase?> {
  DatabaseCubit() : super(null);
  Future<void> initializeDatabase() async {
    final database = await $FloorAppDataBase
        .databaseBuilder('app_database.db')
        .build();
    emit(database);
  }
}

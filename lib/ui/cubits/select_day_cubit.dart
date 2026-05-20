import 'package:flutter_bloc/flutter_bloc.dart';

class SelectDayCubit extends Cubit<DateTime> {
  SelectDayCubit() : super(DateTime.now());

  void selectDay(DateTime date) {
    emit(DateTime(date.year, date.month, date.day));
  }
}

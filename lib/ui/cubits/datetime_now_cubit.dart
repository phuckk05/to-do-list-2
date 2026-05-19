import 'package:flutter_bloc/flutter_bloc.dart';

class DatetimeNowCubit extends Cubit<DateTime> {
  DatetimeNowCubit() : super(DateTime.now());

  void updateDate(DateTime newDate) {
    emit(newDate);
  }
}

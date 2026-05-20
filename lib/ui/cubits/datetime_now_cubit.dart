import 'package:flutter_bloc/flutter_bloc.dart';

class DatetimeNowCubit extends Cubit<DateTime> {
  DatetimeNowCubit() : super(DateTime.now());

  void updateDate(DateTime newDate) {
    print('emit date = $newDate');
    emit(
      DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        DateTime.now().hour,
        DateTime.now().minute,
        DateTime.now().second,
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class SelectDayCubit extends Cubit<int> {
  SelectDayCubit() : super(DateTime.now().day);

  void selectDay(int day) {
    emit(day);
  }
}

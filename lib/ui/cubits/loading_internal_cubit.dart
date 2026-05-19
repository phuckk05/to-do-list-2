import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingInternalCubit extends Cubit<bool> {
  LoadingInternalCubit() : super(false);

  void setLoading(bool loading) {
    emit(loading);
  }
}

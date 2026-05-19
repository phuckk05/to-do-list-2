import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingGlobalCubit extends Cubit<bool> {
  LoadingGlobalCubit() : super(false);

  void setLoading(bool loading) {
    emit(loading);
  }
}

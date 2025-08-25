import 'package:flutter_bloc/flutter_bloc.dart';

/// Easy little cubit to manage the pop route state.
/// This is used to show or hide a back button or something like that.
///
class PopRouteCubit extends Cubit<bool> {
  PopRouteCubit() : super(false);

  void updateCanPop(bool canPop) {
    if (state != canPop) {
      emit(canPop);
    }
  }
}

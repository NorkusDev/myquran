import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navbar_event.dart';
part 'bottom_navbar_state.dart';

class BottomNavbarBloc extends Bloc<BottomNavbarEvent, BottomNavbarState> {
  BottomNavbarBloc() : super(const BottomNavbarState()) {
    on<BottomNavbarEvent>((event, emit) {});
    on<BottomNavbarChangeEvent>(_onChangePage);
  }

  void _onChangePage(
      BottomNavbarChangeEvent event, Emitter<BottomNavbarState> emit) {
    if (event.index == 3) {
      emit(state.copyWith(isVisible: false, indexPage: event.index));
    } else {
      emit(
        state.copyWith(
          indexPage: event.index,
          isVisible: true,
        ),
      );
    }
  }
}

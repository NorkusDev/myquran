part of 'bottom_navbar_bloc.dart';

sealed class BottomNavbarEvent extends Equatable {
  final int index;
  const BottomNavbarEvent(this.index);

  @override
  List<Object> get props => [index];
}

class BottomNavbarChangeEvent extends BottomNavbarEvent {
  const BottomNavbarChangeEvent(super.index);
  @override
  List<Object> get props => [index];
}

part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChangeEvent extends ThemeEvent {
  @override
  List<Object> get props => [];
}

class ThemeInitialEvent extends ThemeEvent {
  @override
  List<Object> get props => [];
}

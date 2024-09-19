part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeType theme;

  const ThemeState({
    this.theme = ThemeType.light,
  });

  ThemeState copyWith({
    ThemeType? theme,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object> get props => [theme];
}

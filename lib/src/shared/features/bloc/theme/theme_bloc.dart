import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasource/theme/local_data_source.dart';
import '../../../data/storage/storage.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeLocalDataSource theme;
  ThemeBloc(super.initialTheme, this.theme) {
    on<ThemeEvent>((event, emit) {});
    on<ThemeChangeEvent>(_themeChangeEvent);
    on<ThemeInitialEvent>(_themeInitialEvent);
  }
  void _themeInitialEvent(
      ThemeInitialEvent event, Emitter<ThemeState> emit) async {
    final type = await theme.theme();
    emit(state.copyWith(theme: type));
    return;
  }

  void _themeChangeEvent(
      ThemeChangeEvent event, Emitter<ThemeState> emit) async {
    await theme.changeTheme(
      StorageValue(
        key: 'app_theme',
        value: state.theme.isDark ? 'light' : 'dark',
      ),
    );
    emit(
      state.copyWith(
        theme: state.theme.isDark ? ThemeType.light : ThemeType.dark,
      ),
    );
    return;
  }
}

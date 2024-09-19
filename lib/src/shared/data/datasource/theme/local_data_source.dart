import '../../storage/storage.dart';

enum ThemeType { light, dark }

abstract class ThemeLocalDataSource {
  Future<ThemeType> theme();
  Future<void> changeTheme(StorageValue value);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final Storage storage;
  const ThemeLocalDataSourceImpl({
    required this.storage,
  });

  @override
  Future<void> changeTheme(StorageValue data) async {
    final theme = await storage.write(
      StorageValue(
        key: 'app_theme',
        value: data.value,
      ),
    );
    return theme;
  }

  @override
  Future<ThemeType> theme() async {
    final theme = await storage.read('app_theme');
    if (theme == "dark") {
      return ThemeType.dark;
    }
    return ThemeType.light;
  }
}

extension ThemeTypeX on ThemeType {
  bool get isLight => this == ThemeType.light;
  bool get isDark => this == ThemeType.dark;
}

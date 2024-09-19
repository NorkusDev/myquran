import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/constant/theme/app_theme.dart';
import 'src/core/routes/app_route.dart';
import 'src/injection.dart' as inject;
import 'src/shared/data/datasource/theme/local_data_source.dart';
import 'src/shared/features/bloc/theme/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inject.init();
  runApp(BlocProvider(
    create: (context) => inject.sl<ThemeBloc>()..add(ThemeInitialEvent()),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouteWithAuto router;

  @override
  void initState() {
    router = AppRouteWithAuto();
    super.initState();
  }

  @override
  void dispose() {
    context.read<ThemeBloc>().close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: router.config(),
          title: 'MyQuran App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.theme.isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';

import 'app_route.gr.dart';

@AutoRouterConfig()
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouteWithAuto extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NavigationBarWidget.page, initial: false),
        AutoRoute(page: AyatRoutes.page),
        AutoRoute(page: SuratRoutes.page, initial: true),
      ];
}

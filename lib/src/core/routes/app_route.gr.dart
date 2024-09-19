// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:quran_app/src/features/prayers_time/presentation/screens/prayers_screen.dart'
    as _i3;
import 'package:quran_app/src/features/surat/presentation/screens/ayat_screens.dart'
    as _i1;
import 'package:quran_app/src/features/surat/presentation/screens/surat_screens.dart'
    as _i4;
import 'package:quran_app/src/shared/features/widgets/navigation_bar_widget.dart'
    as _i2;

/// generated route for
/// [_i1.AyatScreens]
class AyatRoutes extends _i5.PageRouteInfo<AyatRoutesArgs> {
  AyatRoutes({
    int index = 0,
    int suratNumber = 1,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          AyatRoutes.name,
          args: AyatRoutesArgs(
            index: index,
            suratNumber: suratNumber,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AyatRoutes';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<AyatRoutesArgs>(orElse: () => const AyatRoutesArgs());
      return _i5.WrappedRoute(
          child: _i1.AyatScreens(
        index: args.index,
        suratNumber: args.suratNumber,
        key: args.key,
      ));
    },
  );
}

class AyatRoutesArgs {
  const AyatRoutesArgs({
    this.index = 0,
    this.suratNumber = 1,
    this.key,
  });

  final int index;

  final int suratNumber;

  final _i6.Key? key;

  @override
  String toString() {
    return 'AyatRoutesArgs{index: $index, suratNumber: $suratNumber, key: $key}';
  }
}

/// generated route for
/// [_i2.NavigationBarWidget]
class NavigationBarWidget extends _i5.PageRouteInfo<void> {
  const NavigationBarWidget({List<_i5.PageRouteInfo>? children})
      : super(
          NavigationBarWidget.name,
          initialChildren: children,
        );

  static const String name = 'NavigationBarWidget';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.NavigationBarWidget();
    },
  );
}

/// generated route for
/// [_i3.PrayerScreen]
class PrayerRoute extends _i5.PageRouteInfo<void> {
  const PrayerRoute({List<_i5.PageRouteInfo>? children})
      : super(
          PrayerRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrayerRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.PrayerScreen();
    },
  );
}

/// generated route for
/// [_i4.SuratScreens]
class SuratRoutes extends _i5.PageRouteInfo<void> {
  const SuratRoutes({List<_i5.PageRouteInfo>? children})
      : super(
          SuratRoutes.name,
          initialChildren: children,
        );

  static const String name = 'SuratRoutes';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i4.SuratScreens());
    },
  );
}

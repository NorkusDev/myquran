import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../bloc/navbar/bloc/bottom_navbar_bloc.dart';

@RoutePage()
class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> items = [
    PersistentBottomNavBarItem(icon: const Icon(Icons.home)),
    PersistentBottomNavBarItem(icon: const Icon(Icons.search)),
    PersistentBottomNavBarItem(icon: const Icon(Icons.category)),
    PersistentBottomNavBarItem(icon: const Icon(Icons.paragliding)),
  ];
  List<Widget> screens = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavbarBloc(),
      child: BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
        builder: (context, state) {
          return Scaffold(
            appBar: !state.isVisible
                ? AppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    title: const Text("Page Special"),
                    leading: IconButton(
                        onPressed: () {
                          Future.value(
                            [
                              _controller.jumpToTab(0),
                              context
                                  .read<BottomNavbarBloc>()
                                  .add(const BottomNavbarChangeEvent(0)),
                            ],
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                  )
                : null,
            body: PersistentTabView(
              context,
              screens: screens,
              items: items,
              controller: _controller,
              onItemSelected: (int index) =>
                  context.read<BottomNavbarBloc>().add(
                        BottomNavbarChangeEvent(index),
                      ),
              isVisible: state.isVisible,
              handleAndroidBackButtonPress: true,
            ),
          );
        },
      ),
    );
  }
}

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import '../../../../injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/prayers/prayers_bloc.dart';

@RoutePage()
class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PrayersBloc>()..add(PrayersFetchEvent()),
      child: Scaffold(
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: BlocBuilder<PrayersBloc, PrayersState>(
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              if (state.status.isLoading) {
                return const CircularProgressIndicator();
              }
              if (state.status.isFailure) {
                return Text(
                  state.message,
                );
              }
              return ListView.builder(
                itemBuilder: (c, i) {
                  var jadwal = state.sholatEntity?.data.jadwal;
                  return Text(
                    ' ${jadwal?[i].date}',
                  );
                },
                itemCount: state.sholatEntity?.data.jadwal.length,
              );
            },
          ),
        ),
      ),
    );
  }
}

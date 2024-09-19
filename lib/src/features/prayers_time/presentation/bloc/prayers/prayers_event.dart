part of 'prayers_bloc.dart';

sealed class PrayersEvent extends Equatable {
  const PrayersEvent();

  @override
  List<Object> get props => [];
}

class PrayersFetchEvent extends PrayersEvent {}

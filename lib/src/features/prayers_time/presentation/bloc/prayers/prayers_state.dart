// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'prayers_bloc.dart';

enum PrayerStatus { initial, loading, success, failed }

class PrayersState extends Equatable {
  final PrayerStatus status;
  final SholatEntity? sholatEntity;
  final String message;
  const PrayersState({
    this.status = PrayerStatus.initial,
    this.sholatEntity,
    this.message = "",
  });

  PrayersState copyWith({
    PrayerStatus? status,
    SholatEntity? sholatEntity,
    String? message,
  }) {
    return PrayersState(
      status: status ?? this.status,
      sholatEntity: sholatEntity ?? this.sholatEntity,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, sholatEntity, message];
}

extension PrayerStatusX on PrayerStatus {
  bool get isInitial => this == PrayerStatus.initial;
  bool get isLoading => this == PrayerStatus.loading;
  bool get isSuccess => this == PrayerStatus.success;
  bool get isFailure => this == PrayerStatus.failed;
}

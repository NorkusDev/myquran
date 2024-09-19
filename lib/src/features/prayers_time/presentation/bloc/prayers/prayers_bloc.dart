import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/exception/app_exception.dart';
import '../../../domain/usecases/get_prayers_time_usecase.dart';
import '../../../../../shared/domain/entities/sholat_entity.dart';
import '../../../../../shared/domain/usecases/params.dart';

part 'prayers_event.dart';
part 'prayers_state.dart';

class PrayersBloc extends Bloc<PrayersEvent, PrayersState> {
  final GetPrayersTimeUsecase prayersTimeUsecase;
  PrayersBloc(this.prayersTimeUsecase) : super(const PrayersState()) {
    on<PrayersEvent>((event, emit) {});
    on<PrayersFetchEvent>(_fetch);
  }

  void _fetch(PrayersEvent event, Emitter<PrayersState> emit) async {
    emit(state.copyWith(status: PrayerStatus.loading));
    Either<AppException, SholatEntity> theCase =
        await prayersTimeUsecase(NoParams());
    theCase.fold(
        (left) => emit(
              state.copyWith(
                status: PrayerStatus.failed,
                message: left.message,
              ),
            ), (right) {
      emit(state.copyWith(status: PrayerStatus.success, sholatEntity: right));
    });
  }
}

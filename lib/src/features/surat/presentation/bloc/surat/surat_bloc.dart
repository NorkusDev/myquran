import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/core.dart';
import '../../../../../shared/domain/entities/quran/ayat_entity.dart';
import '../../../../../shared/domain/entities/quran/surat_entity.dart';
import '../../../../../shared/domain/usecases/params.dart';
import '../../../domain/usecases/get_surat_detail_usecase.dart';
import '../../../domain/usecases/get_surat_usecase.dart';

part 'surat_event.dart';
part 'surat_state.dart';

class SuratBloc extends Bloc<SuratEvent, SuratState> {
  final GetSuratUsecase suratUsecase;
  final GetSuratDetailUsecase detailUsecase;
  SuratBloc({required this.suratUsecase, required this.detailUsecase})
      : super(const SuratState()) {
    on<SuratEvent>((event, emit) {});
    on<SuratGetDetailEvent>(_suratGetDetailEvent);
    on<SuratGetEvent>(_suratGetEvent);
  }

  void _suratGetEvent(SuratGetEvent event, Emitter<SuratState> emit) async {
    emit(state.copyWith(status: StatusSurat.loading));
    Either<AppException, List<SuratEntity>> surat =
        await suratUsecase(NoParams());
    surat.fold(
      (left) => emit(
        state.copyWith(
          status: StatusSurat.failed,
          message: left.message,
        ),
      ),
      (right) => emit(
        state.copyWith(
          surat: right,
          status: StatusSurat.success,
        ),
      ),
    );
  }

  void _suratGetDetailEvent(
      SuratGetDetailEvent event, Emitter<SuratState> emit) async {
    emit(state.copyWith(status: StatusSurat.loading));
    Either<AppException, AyatEntity> ayat =
        await detailUsecase(GetSuratDetailParams(id: event.id));
    ayat.fold(
      (left) => emit(
        state.copyWith(
          status: StatusSurat.failed,
          message: left.message,
        ),
      ),
      (right) => emit(
        state.copyWith(
          status: StatusSurat.success,
          ayat: right,
        ),
      ),
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/exception/app_exception.dart';
import '../../../../shared/domain/entities/quran/ayat_entity.dart';
import '../../../../shared/domain/usecases/usecase.dart';
import '../abstraction/repositories.dart';

class GetSuratDetailUsecase
    implements Usecase<AyatEntity, GetSuratDetailParams> {
  final SuratRepository repository;

  GetSuratDetailUsecase(this.repository);

  @override
  Future<Either<AppException, AyatEntity>> call(
      GetSuratDetailParams param) async {
    return await repository.getDetailSurat(param.id);
  }
}

class GetSuratDetailParams extends Equatable {
  final int id;

  const GetSuratDetailParams({required this.id});

  @override
  List<Object> get props => [id];
}

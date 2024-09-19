import 'package:dartz/dartz.dart';

import '../../../../core/exception/app_exception.dart';
import '../../../../shared/domain/entities/quran/surat_entity.dart';
import '../../../../shared/domain/usecases/params.dart';
import '../../../../shared/domain/usecases/usecase.dart';
import '../abstraction/repositories.dart';

class GetSuratUsecase implements Usecase<List<SuratEntity>, NoParams> {
  final SuratRepository repository;
  const GetSuratUsecase(this.repository);
  @override
  Future<Either<AppException, List<SuratEntity>>> call(NoParams param) async {
    print("got hit");
    return await repository.getSurat();
  }
}

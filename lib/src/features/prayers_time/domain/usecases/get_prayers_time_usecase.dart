import 'package:dartz/dartz.dart';

import '../../../../core/exception/app_exception.dart';
import '../../../../shared/domain/entities/sholat_entity.dart';
import '../../../../shared/domain/usecases/params.dart';
import '../../../../shared/domain/usecases/usecase.dart';
import '../abstraction/repositories.dart';

class GetPrayersTimeUsecase implements Usecase<SholatEntity, NoParams> {
  final PrayersRepositories prayers;

  GetPrayersTimeUsecase(this.prayers);
  @override
  Future<Either<AppException, SholatEntity>> call(NoParams param) async {
    return await prayers.fetch();
  }
}

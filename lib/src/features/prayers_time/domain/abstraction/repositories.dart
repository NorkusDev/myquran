import 'package:dartz/dartz.dart';
import '../../../../core/exception/app_exception.dart';
import '../../../../shared/domain/entities/sholat_entity.dart';

abstract class PrayersRepositories {
  Future<Either<AppException, SholatEntity>> fetch();
}

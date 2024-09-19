import 'package:dartz/dartz.dart';
import '../datasources/remote_data_sources.dart';
import '../../../../core/exception/app_exception.dart';
import '../../domain/abstraction/repositories.dart';
import '../../../../shared/domain/entities/sholat_entity.dart';

class PrayersRepositoriesImpl implements PrayersRepositories {
  final PrayersTimeRemoteDataSource remoteDataSource;

  PrayersRepositoriesImpl(this.remoteDataSource);
  @override
  Future<Either<AppException, SholatEntity>> fetch() async {
    final res = await remoteDataSource.fetch();
    return res.fold((left) => Left(left), (right) => Right(right.toEntity()));
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/exception/app_exception.dart';
import '../../../../core/network/network_checker.dart';
import '../../../../shared/domain/entities/quran/ayat_entity.dart';
import '../../../../shared/domain/entities/quran/surat_entity.dart';
import '../../domain/abstraction/repositories.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';

class SuratRepositoryImpl implements SuratRepository {
  final SuratRemoteDataSource remoteDataSource;
  final SuratLocalDataSource localDataSource;
  final NetworkChecker checker;
  const SuratRepositoryImpl(
      this.remoteDataSource, this.localDataSource, this.checker);

  @override
  Future<Either<AppException, AyatEntity>> getDetailSurat(int id) async {
    if (await checker.isConnected) {
      final remote = await remoteDataSource.getDetailSurat(id);
      return remote.fold(
        (left) => Left(left),
        (r) {
          localDataSource.saveAyat(r);
          return Right(
            r.toEntity(),
          );
        },
      );
    }
    final local = await localDataSource.getDetailSurat(id);
    return local.fold((left) => Left(left), (r) => Right(r.toEntity()));
  }

  @override
  Future<Either<AppException, List<SuratEntity>>> getSurat() async {
    if (await checker.isConnected) {
      final remote = await remoteDataSource.getSurat();
      return remote.fold(
        (left) => Left(left),
        (r) {
          localDataSource.saveSurat(r);
          final List<SuratEntity> surat = r.map((e) => e.toEntity()).toList();
          return Right(
            surat,
          );
        },
      );
    }
    final local = await localDataSource.getSurat();
    return local.fold((left) => Left(left), (r) {
      final List<SuratEntity> surat = r.map((e) => e.toEntity()).toList();
      return Right(surat);
    });
  }
}

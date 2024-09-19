import 'package:dartz/dartz.dart';

import '../../../../core/exception/app_exception.dart';
import '../../../../shared/domain/entities/quran/ayat_entity.dart';
import '../../../../shared/domain/entities/quran/surat_entity.dart';
import '../../domain/abstraction/repositories.dart';
import '../datasources/remote_data_source.dart';

class SuratRepositoryImpl implements SuratRepository {
  final SuratRemoteDataSource remoteDataSource;
  const SuratRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<AppException, AyatEntity>> getDetailSurat(int id) async {
    final remote = await remoteDataSource.getDetailSurat(id);
    return remote.fold(
      (left) => Left(left),
      (r) => Right(
        r.toEntity(),
      ),
    );
  }

  @override
  Future<Either<AppException, List<SuratEntity>>> getSurat() async {
    final remote = await remoteDataSource.getSurat();
    return remote.fold(
      (left) => Left(left),
      (r) {
        final List<SuratEntity> surat = r.map((e) => e.toEntity()).toList();
        return Right(
          surat,
        );
      },
    );
  }
}

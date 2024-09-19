import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../../shared/domain/entities/quran/ayat_entity.dart';
import '../../../../shared/domain/entities/quran/surat_entity.dart';

abstract class SuratRepository {
  Future<Either<AppException, List<SuratEntity>>> getSurat();
  Future<Either<AppException, AyatEntity>> getDetailSurat(int id);
}

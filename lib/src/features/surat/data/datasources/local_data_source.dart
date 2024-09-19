import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../../shared/data/models/ayat/ayat_model.dart';
import '../../../../shared/data/models/surah/surah_model.dart';
import '../../../../shared/data/storage/storage.dart';

abstract class SuratLocalDataSource {
  Future<Either<AppException, List<SurahModel>>> getSurat();
  Future<void> saveSurat(List<SurahModel> surat);
  Future<Either<AppException, AyatModel>> getDetailSurat(int id);
  Future<void> saveAyat(AyatModel ayat);
}

class SuratLocalDataSourceImpl implements SuratLocalDataSource {
  final Storage storage;

  const SuratLocalDataSourceImpl({
    required this.storage,
  });

  @override
  Future<Either<AppException, AyatModel>> getDetailSurat(int id) async {
    final data = await storage.read("${id}_ayat");
    if (data == null) {
      return const Left(
        AppException(
          message: "Failed to get local data",
          statusCode: 404,
          identifier: "local_storage",
        ),
      );
    }
    final ayat = jsonDecode(data);
    return Right(AyatModel.fromJson(ayat));
  }

  @override
  Future<Either<AppException, List<SurahModel>>> getSurat() async {
    final data = await storage.read('all_surat');
    if (data == null) {
      return const Left(
        AppException(
          message: "Failed to get local data",
          statusCode: 404,
          identifier: "local_storage",
        ),
      );
    }
    final surat = jsonDecode(data) as List;
    return Right(
      surat.map((e) => SurahModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<void> saveAyat(AyatModel ayat) async {
    final save = await storage.write(
      StorageValue(
        key: "${ayat.nomor}_ayat",
        value: jsonEncode(
          ayat.toJson(),
        ),
      ),
    );
    return save;
  }

  @override
  Future<void> saveSurat(List<SurahModel> surat) async {
    final response = await storage.write(
      StorageValue(
        key: 'all_surat',
        value: jsonEncode(
          surat.map((e) => e.toJson()).toList(),
        ),
      ),
    );
    return response;
  }
}

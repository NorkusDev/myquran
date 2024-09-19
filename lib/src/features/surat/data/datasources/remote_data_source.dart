import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../../shared/data/models/ayat/ayat_model.dart';
import '../../../../shared/data/models/surah/surah_model.dart';

abstract class SuratRemoteDataSource {
  Future<Either<AppException, List<SurahModel>>> getSurat();
  Future<Either<AppException, AyatModel>> getDetailSurat(int id);
}

class SuratRemoteDataSourceImpl implements SuratRemoteDataSource {
  final NetworkContainer http;
  const SuratRemoteDataSourceImpl(this.http);

  @override
  Future<Either<AppException, AyatModel>> getDetailSurat(int id) async {
    final response = await http.get("/surah/$id", header: HeadersType.json);
    return response.fold(
      (left) => Left(left),
      (r) => Right(
        AyatModel.fromJson(
          r.data,
        ),
      ),
    );
  }

  @override
  Future<Either<AppException, List<SurahModel>>> getSurat() async {
    final response = await http.get('/surah', header: HeadersType.json);
    return response.fold(
      (l) => Left(l),
      (r) {
        final data = r.data as List;
        return Right(
          data
              .map((e) => SurahModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      },
    );
  }
}

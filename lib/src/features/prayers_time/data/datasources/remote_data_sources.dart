import 'package:dartz/dartz.dart';
import '../../../../core/exception/app_exception.dart';
import '../../../../core/network/network_container.dart';
import '../../../../shared/data/models/prayers/sholat_model.dart';

abstract class PrayersTimeRemoteDataSource {
  Future<Either<AppException, SholatModel>> fetch();
}

class PrayersTimeRemoteDataSourcesImpl implements PrayersTimeRemoteDataSource {
  final NetworkContainer http;
  const PrayersTimeRemoteDataSourcesImpl(this.http);

  @override
  Future<Either<AppException, SholatModel>> fetch() async {
    String url = "/v2/sholat/jadwal/1431/2024/08sd";
    final response = await http.get(url, header: HeadersType.json);
    return response.fold(
      (l) => Left(l),
      (r) {
        if (r.data == null) {
          return const Left(
            AppException(
              message: "Data tidak dapat ditemukan",
              statusCode: 0,
              identifier: "prayers_time",
            ),
          );
        }
        return Right(SholatModel.fromJson(r.data));
      },
    );
  }
}

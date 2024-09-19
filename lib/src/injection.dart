import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio.dart';
import 'core/network/network_container.dart';
import 'features/prayers_time/data/datasources/remote_data_sources.dart';
import 'features/prayers_time/data/repositories/prayers_repositories.dart';
import 'features/prayers_time/domain/abstraction/repositories.dart';
import 'features/prayers_time/domain/usecases/get_prayers_time_usecase.dart';
import 'features/prayers_time/presentation/bloc/prayers/prayers_bloc.dart';
import 'features/surat/data/datasources/remote_data_source.dart';
import 'features/surat/data/repositories/repository.dart';
import 'features/surat/domain/abstraction/repositories.dart';
import 'features/surat/domain/usecases/get_surat_detail_usecase.dart';
import 'features/surat/domain/usecases/get_surat_usecase.dart';
import 'features/surat/presentation/bloc/surat/surat_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  //! Bloc
  sl.registerFactory(() => PrayersBloc(sl()));
  sl.registerFactory(() => SuratBloc(suratUsecase: sl(), detailUsecase: sl()));
  //! DataSources
  sl.registerLazySingleton<PrayersTimeRemoteDataSource>(
      () => PrayersTimeRemoteDataSourcesImpl(sl()));
  sl.registerLazySingleton<SuratRemoteDataSource>(
      () => SuratRemoteDataSourceImpl(sl()));
  //! Repositories
  sl.registerLazySingleton<PrayersRepositories>(
      () => PrayersRepositoriesImpl(sl()));
  sl.registerLazySingleton<SuratRepository>(() => SuratRepositoryImpl(sl()));
  //! UseCases
  sl.registerLazySingleton(() => GetPrayersTimeUsecase(sl()));
  //! Surat

  sl.registerLazySingleton(() => GetSuratDetailUsecase(sl()));
  sl.registerLazySingleton(() => GetSuratUsecase(sl()));
  //! Core
  //! Network
  sl.registerLazySingleton<NetworkContainer>(() => DioNetworkContainer(sl()));
  sl.registerLazySingleton(() => Dio());
}

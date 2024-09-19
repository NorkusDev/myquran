import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio.dart';
import 'core/network/network_checker.dart';
import 'core/network/network_container.dart';
import 'features/surat/data/datasources/local_data_source.dart';
import 'features/surat/data/datasources/remote_data_source.dart';
import 'features/surat/data/repositories/repository.dart';
import 'features/surat/domain/abstraction/repositories.dart';
import 'features/surat/domain/usecases/get_surat_detail_usecase.dart';
import 'features/surat/domain/usecases/get_surat_usecase.dart';
import 'features/surat/presentation/bloc/surat/surat_bloc.dart';
import 'shared/data/datasource/theme/local_data_source.dart';
import 'shared/data/storage/secure_storage_service.dart';
import 'shared/data/storage/storage.dart';
import 'shared/features/bloc/theme/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Shared
  //! Theme
  sl.registerLazySingleton<Storage>(() => SecureStorageService());
  Storage storage = sl<Storage>();
  String? theme = await storage.read("app_theme");
  ThemeType type = theme == "dark" ? ThemeType.dark : ThemeType.light;

  sl.registerFactory(() => ThemeBloc(ThemeState(theme: type), sl()));

  //! Features
  //! Bloc
  sl.registerFactory(() => SuratBloc(suratUsecase: sl(), detailUsecase: sl()));

  //! DataSources
  sl.registerLazySingleton<SuratRemoteDataSource>(
      () => SuratRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<SuratLocalDataSource>(
      () => SuratLocalDataSourceImpl(storage: sl()));
  sl.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(storage: sl()));
  //! Repositories
  sl.registerLazySingleton<SuratRepository>(
      () => SuratRepositoryImpl(sl(), sl(), sl()));

  //! Surat

  sl.registerLazySingleton(() => GetSuratDetailUsecase(sl()));
  sl.registerLazySingleton(() => GetSuratUsecase(sl()));
  //! Core
  //! Network
  sl.registerLazySingleton<NetworkContainer>(() => DioNetworkContainer(sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<NetworkChecker>(() => NetworkCheckerImpl());
}

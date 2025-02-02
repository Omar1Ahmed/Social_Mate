// core/di/di.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/posts/data/data_source/post_remote_data_source_impl.dart';
import '../../features/posts/data/repository/post_repository_impl.dart';
import '../../features/posts/domain/repository/post_remote_data_source.dart';
import '../../features/posts/domain/repository/post_repository.dart';
import '../../features/posts/presentation/homePage/logic/cubit/home_cubit_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // ---------------------------- Dio Setup ----------------------------
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(
      baseUrl: 'https://your-api-url.com/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    )),
  );

  // ------------------------- Data Sources --------------------------
  getIt.registerFactory<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  // ------------------------ Repositories --------------------------
  getIt.registerFactory<PostRepository>(
    () => PostRepositoryImpl(remoteDataSource: getIt<PostRemoteDataSource>()),
  );
  // -------------------------- Cubits ------------------------------
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<PostRepository>()),
  );
  

}
List<BlocProvider> getBlocProviders() => [
      BlocProvider<HomeCubit>(create: (_) => getIt<HomeCubit>()),
    ];

// core/di/di.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/filtering/data/datasources/filtered_posts_remote_source.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtering_cubit.dart';
// import 'package:social_media/features/filtering/data/repositories/filtered_post_repo_impl.dart';

// import '../../features/filtering/domain/repositories/filtered_post_repo.dart';
import '../../features/posts/data/data_source/post_remote_data_source_impl.dart';
import '../../features/posts/data/repository/post_repository_impl.dart';
import '../../features/posts/domain/repository/post_remote_data_source.dart';
import '../../features/posts/domain/repository/post_repository.dart';
import '../../features/posts/presentation/homePage/logic/cubit/post_cubit_cubit.dart';

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

  getIt.registerLazySingleton<FilteredPostsRemoteSource>(getIt());

  // ------------------------ Repositories --------------------------
  getIt.registerFactory<PostRepository>(
    () => PostRepositoryImpl(remoteDataSource: getIt<PostRemoteDataSource>()),
  );

  // getIt.registerFactory<FilteredPostRepo>(
  //   () => FilteredPostRepoImpl(
  //     filteredPostsRemoteSource: getIt<FilteredPostsRemoteSource>(),
  //     networkInfo: getIt(), // Ensure NetworkInfo is registered
  //   ),
  // );
  // -------------------------- Cubits ------------------------------
  getIt.registerFactory<PostCubitCubit>(
    () => PostCubitCubit(getIt<PostRepository>()),
  );

  getIt.registerFactory(() => FilteringCubit(getIt()));
}

List<BlocProvider> getBlocProviders() => [
      BlocProvider<PostCubitCubit>(create: (_) => getIt<PostCubitCubit>()),
    ];

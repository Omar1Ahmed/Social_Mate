// core/di/di.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/features/filtering/could_be_shared/network_clients/dio_network_client.dart';
import 'package:social_media/features/filtering/could_be_shared/network_clients/fake_dio_network_client.dart';
import 'package:social_media/features/filtering/could_be_shared/network_info/network_info.dart';
import 'package:social_media/features/filtering/data/datasources/filtered_posts_remote_source.dart';
import 'package:social_media/features/filtering/data/repositories/filtered_post_repo_imp.dart';
import 'package:social_media/features/filtering/domain/repositories/filtered_post_repo.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtering_cubit.dart';

// import '../../features/filtering/domain/repositories/filtered_post_repo.dart';
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

  getIt.registerLazySingleton<DioNetworkClient>(() => FakeDioNetworkClient());
  // |------------------------------------------------------------------\
  // |-------------------------- Data Sources ------------------------------\
  // |------------------------------------------------------------------\

  getIt.registerFactory<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoConnection(connectionChecker: getIt()),
  );
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  getIt.registerLazySingleton(
      () => NetworkInfoConnection(connectionChecker: getIt()));
  getIt.registerLazySingleton<FilteredPostsRemoteSource>(
      () => FilteredPostsRemoteSourceImpl(
            dioNetworkClient: getIt<DioNetworkClient>(),
          ));
  // |------------------------------------------------------------------\
  // |-------------------------- Repositories ------------------------------\
  // |------------------------------------------------------------------\

  getIt.registerFactory<PostRepository>(
    () => PostRepositoryImpl(remoteDataSource: getIt<PostRemoteDataSource>()),
  );

  getIt.registerLazySingleton<FilteredPostRepo>(() => FilteredPostRepoImp(
      networkInfo: getIt(), filteredPostsRemoteSource: getIt()));
  // |------------------------------------------------------------------\
  // |-------------------------- Cubits ------------------------------\
  // |------------------------------------------------------------------\
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<PostRepository>()),
  );

  getIt.registerFactory(() => FilteringCubit(getIt()));

  // |------------------------------------------------------------------\
  // |-------------------------- Services ------------------------------\
  // |------------------------------------------------------------------\

  final sharedPrefHelper = SharedPrefHelper();
  await sharedPrefHelper.init();
  getIt.registerSingleton<SharedPrefHelper>(sharedPrefHelper);
}

// core/di/di.dart
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:social_media/core/di/diInstancesHelper.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/core/userMainDetails/jwt_token_decode/data/repository/jwt_token_decode_repository_imp.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/authentication/data/data_source/AuthenticaionRemoteDataSource.dart';
import 'package:social_media/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:social_media/features/authentication/data/repository/authentication_repository_imp.dart';
import 'package:social_media/features/authentication/domain/repository/authentication_repository.dart';
import 'package:social_media/features/authentication/presentation/logic/auth_cubit.dart';
import 'package:social_media/features/filtering/could_be_shared/fake_end_points/real_end_points.dart';
import 'package:social_media/features/filtering/could_be_shared/network_clients/dio_network_client.dart';
import 'package:social_media/features/filtering/could_be_shared/network_info/network_info.dart';
import 'package:social_media/features/filtering/data/datasources/filtered_posts_remote_source.dart';
import 'package:social_media/features/filtering/data/repositories/filtered_post_repo_imp.dart';
import 'package:social_media/features/filtering/domain/repositories/filtered_post_repo.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtering_cubit.dart';
import '../../features/posts/data/data_source/post_remote_data_source_impl.dart';
import '../../features/posts/data/repository/post_repository_impl.dart' as impl;
import '../../features/posts/domain/repository/post_remote_data_source.dart';
import '../../features/posts/domain/repository/post_repository.dart' as repo;
import '../../features/posts/domain/repository/post_repository.dart';
import '../../features/posts/presentation/homePage/logic/cubit/home_cubit_cubit.dart';
import '../network/dio_client.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // |------------------------------------------------------------------\
  // |-------------------------- Services ------------------------------\
  // |------------------------------------------------------------------\

  // shared Preferences
  final sharedPrefHelper = SharedPrefHelper();
  await sharedPrefHelper.init();
  getIt.registerSingleton<SharedPrefHelper>(sharedPrefHelper);

  // Network info
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoConnection(connectionChecker: getIt()),
  );
  getIt.registerLazySingleton(() => InternetConnectionChecker);

  getIt.registerLazySingleton(() => NetworkInfoConnection(connectionChecker: getIt()));

  // ---------------------------- Dio Setup ----------------------------

  // users Management api  client
  getIt.registerLazySingleton<DioClient>(() => DioClient(baseUrl: RealEndPoints.realUserBaseUrl), instanceName: diInstancesHelper.userDioClient);

  // posts api client
  getIt.registerLazySingleton<DioClient>(() => DioClient(baseUrl: RealEndPoints.realPostsBaseUrl), instanceName: diInstancesHelper.PostsDioClient);

  // |------------------------------------------------------------------\
  // |-------------------------- Data Sources ------------------------------\
  // |------------------------------------------------------------------\

  getIt.registerFactory<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(dio: getIt<DioClient>(instanceName: diInstancesHelper.PostsDioClient), userMainDetails: getIt<userMainDetailsCubit>()),
  );

  getIt.registerLazySingleton<FilteredPostsRemoteSource>(() => FilteredPostsRemoteSourceImpl(
        dioNetworkClient: getIt<DioNetworkClient>(),
      ));

  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthenticationRemoteDataSourceImp(
        dioNetworkClient: getIt<DioClient>(
          instanceName: diInstancesHelper.userDioClient,
        ),
      ));
  // |------------------------------------------------------------------\
  // |-------------------------- Repositories ------------------------------\
  // |------------------------------------------------------------------\

  getIt.registerSingleton<JwtTokenDecodeRepositoryImp>(
    JwtTokenDecodeRepositoryImp(),
  );

  // post repository
  getIt.registerFactory<PostRepository>(
    () => impl.PostRepositoryImpl(remoteDataSource: getIt<PostRemoteDataSource>()),
  );

  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImp(networkInfo: getIt(), logInRemoteDataSource: getIt()));
  getIt.registerLazySingleton<FilteredPostRepo>(() => FilteredPostRepoImp(networkInfo: getIt(), filteredPostsRemoteSource: getIt()));
  // |------------------------------------------------------------------\
  // |-------------------------- Cubits ------------------------------\
  // |------------------------------------------------------------------\

  // token Decoder Cubit

  // main User Details Cubit
  getIt.registerSingleton<userMainDetailsCubit>(
    userMainDetailsCubit(getIt<JwtTokenDecodeRepositoryImp>()),
  );

  // Auth Cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt()),
  );

  // home Cubit
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<repo.PostRepository>()),
  );

  // the auth Cubit is here 👇
  //getIt.registerFactory(() => AuthCubit(getIt()));
  getIt.registerFactory(() => FilteringCubit(getIt()));
}

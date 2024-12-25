import 'package:client/core/shared/controller/search/search_cubit.dart';
import 'package:client/features/auth/domain/usecases/edit_profile_info_use_case.dart';
import 'package:client/features/auth/presentation/controller/edit_profile_info/edit_profile_info_cubit.dart';
import 'package:client/features/companies/domain/usecases/get_promoted_companies_usecase.dart';
import 'package:client/features/companies/presentation/controllers/promoted_companies/promoted_companies_cubit.dart';
import 'package:client/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:client/features/home/data/datasources/categories_remote_datasource.dart';
import 'package:client/features/home/data/repositories/categories_repository_impl.dart';
import 'package:client/features/home/domain/repositories/categories_repository.dart';
import 'package:client/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:client/features/companies/presentation/controllers/categories/categories_cubit.dart';
import 'package:client/features/orders/domain/usecases/delete_order_usecase.dart';
import 'package:client/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:client/features/orders/presentation/controllers/orders/orders_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'features/companies/data/datasources/companies_remote_datasource.dart';
import 'features/companies/data/repositories/companies_repository_impl.dart';
import 'features/orders/data/repositories/orders_repository_impl.dart';
import 'features/companies/domain/repositories/companies_repository.dart';
import 'features/orders/domain/repositories/orders_repository.dart';
import 'features/orders/domain/usecases/create_order_usecase.dart';
import 'features/companies/domain/usecases/get_companies_usecase.dart';
import 'features/companies/presentation/controllers/companies/companies_cubit.dart';
import 'features/orders/presentation/controllers/order/order_cubit.dart';
import 'features/home/data/datasources/home_remote_datasource.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_pictures_usecase.dart';
import 'features/home/presentation/controllers/pictures/pictures_cubit.dart';

import 'core/system/domain/usecases/get_language_use_case.dart';
import 'core/system/domain/usecases/set_system_language_use_case.dart';
import 'features/auth/domain/usecases/get_profile_info_usecase.dart';
import 'features/auth/presentation/controller/profile_info/profile_info_cubit.dart';

import 'core/system/data/datasources/language_local_datasource.dart';
import 'core/system/data/repositories/languages_repository_impl.dart';
import 'core/system/domain/repositories/language_repository.dart';
import 'core/system/presentation/controller/language_cubit.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/forget_password_use_case.dart';
import 'features/auth/domain/usecases/is_auth_use_case.dart';
import 'features/auth/domain/usecases/log_in_use_case.dart';
import 'features/auth/domain/usecases/set_details_use_case.dart';
import 'features/auth/domain/usecases/sign_out_use_case.dart';
import 'features/auth/domain/usecases/sign_up_use_case.dart';
import 'features/auth/presentation/controller/details/details_cubit.dart';
import 'features/auth/presentation/controller/forget_password/forget_password_cubit.dart';
import 'features/auth/presentation/controller/log_in_cubit/login_cubit.dart';
import 'features/auth/presentation/controller/sign_out_cubit/sign_out_cubit.dart';
import 'features/auth/presentation/controller/sign_up_cubit/sign_up_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:hive/hive.dart';

import 'core/utils/network_info.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';

GetIt sl = GetIt.instance;

void init() {
  /* ------------------ Auth Feature ------------------ */
  // Use cases
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerLazySingleton<LogInUseCase>(() => LogInUseCase(sl()));
  sl.registerLazySingleton<SetDetailsUsecase>(() => SetDetailsUsecase(sl()));
  sl.registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton<IsAuthUseCase>(() => IsAuthUseCase(sl()));
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl()));
  sl.registerLazySingleton<GetProfileInfoUsecase>(
      () => GetProfileInfoUsecase(sl()));
  sl.registerLazySingleton<EditProfileInfoUseCase>(
      () => EditProfileInfoUseCase(sl()));

  // Bloc
  sl.registerFactory(() => SignUpCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => DetailsCubit(sl(), sl()));
  sl.registerFactory(() => ForgetPasswordCubit(sl()));
  sl.registerFactory(() => SignOutCubit(sl()));
  sl.registerFactory(() => ProfileInfoCubit(sl()));
  sl.registerFactory(() => EditProfileInfoCubit(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl(), sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(sl(), sl(), sl()));

  sl.registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasourceImpl(sl()));

  /* ------------------ Companies Feature ------------------ */
  // Use cases
  sl.registerLazySingleton<GetCompaniesUsecase>(
      () => GetCompaniesUsecase(sl()));
  sl.registerLazySingleton<GetPromotedCompaniesUsecase>(
      () => GetPromotedCompaniesUsecase(sl()));

  // Bloc
  sl.registerFactory<PromotedCompaniesCubit>(
      () => PromotedCompaniesCubit(sl()));

  // Repository
  sl.registerLazySingleton<CompaniesRepository>(
      () => CompaniesRepositoryImpl(sl(), sl()));

  // Datasources
  sl.registerLazySingleton<CompaniesRemoteDatasource>(
      () => CompaniesRemoteDatasourceImpl(sl()));

  /* ------------------ Home Feature ------------------ */
  // Usecases
  sl.registerLazySingleton<GetPicturesUsecase>(() => GetPicturesUsecase(sl()));
  sl.registerLazySingleton<GetCategoriesUsecase>(
      () => GetCategoriesUsecase(sl()));

  // Bloc
  sl.registerFactory(() => PicturesCubit(sl()));
  sl.registerFactory(() => CompaniesCubit(sl()));
  sl.registerFactory(() => CategoriesCubit(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(sl(), sl()));

  // Data sources
  sl.registerLazySingleton<HomeRemoteDatasource>(
      () => HomeRemoteDatasourceImpl(sl()));
  sl.registerLazySingleton<CategoriesRemoteDatasource>(
      () => CategoriesRemoteDatasourceImpl(sl()));

  /* ------------------ Orders Feature ------------------ */
  // Usecases
  sl.registerLazySingleton<CreateOrderUsecase>(() => CreateOrderUsecase(sl()));
  sl.registerLazySingleton<GetOrdersUsecase>(() => GetOrdersUsecase(sl()));
  sl.registerLazySingleton<DeleteOrderUsecase>(() => DeleteOrderUsecase(sl()));

  // Bloc
  sl.registerFactory(() => OrderCubit(sl()));
  sl.registerFactory(() => OrdersCubit(sl(), sl()));

  // Repository
  sl.registerLazySingleton<OrdersRepository>(
      () => OrdersRepositoryImpl(sl(), sl()));

  // Data sources
  sl.registerLazySingleton<OrdersRemoteDatasource>(
      () => OrdersRemoteDatasourceImpl(sl(), sl()));

  /* ------------------ System ------------------ */
  // Use cases
  sl.registerLazySingleton<SetSystemLanguageUsecase>(
      () => SetSystemLanguageUsecase(sl()));
  sl.registerLazySingleton<GetLanguageUseCase>(() => GetLanguageUseCase(sl()));

  // Bloc
  sl.registerFactory(() => LanguageCubit(sl(), sl()));

  // Repository
  sl.registerLazySingleton<LanguageRepository>(
      () => LanguagesRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<LanguageLocalDatasource>(
      () => LanguageLocalDatasourceImpl(sl()));

  /* ------------------ Firebase ------------------ */
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  /* ------------------ Hive ------------------ */
  sl.registerLazySingleton<HiveInterface>(() => Hive);

  /* ------------------ Utils ------------------ */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerFactory<SearchCubit>(() => SearchCubit());
}

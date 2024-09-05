import 'package:e_commerce_app/data/data_source/remote_data_source.dart';
import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';
import 'package:e_commerce_app/domain/use_cases/change_password_usecase.dart';
import 'package:e_commerce_app/domain/use_cases/get_banners_usecase.dart';
import 'package:e_commerce_app/domain/use_cases/get_carts_usecase.dart';
import 'package:e_commerce_app/domain/use_cases/post_logout_usecase.dart';
import 'package:e_commerce_app/domain/use_cases/post_register_data_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  void init() {
    sl.registerLazySingleton(
        () => PostRegisterDataUseCase(baseRepository: sl()));
    sl.registerLazySingleton(() => ChangePasswordUsecase(baseRepository: sl()));
    sl.registerLazySingleton(() => GetCartUsecase(baseRepository: sl()));
    sl.registerLazySingleton(() => GetBannersUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(baseRepository: sl()));
    sl.registerLazySingleton<BaseRepository>(
        () => ShopRepository(baseRemoteDataSource: sl()));

    sl.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());
  }
}

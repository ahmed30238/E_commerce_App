import 'package:e_commerce_app/data/data_source/remote_data_source.dart';
import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  void init() {
    sl.registerLazySingleton<BaseRepository>(
        () => ShopRepository(baseRemoteDataSource: sl()));

    sl.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());

  }
}

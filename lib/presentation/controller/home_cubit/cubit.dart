import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:e_commerce_app/domain/Entity/add&delete_favourites_entity.dart';
import 'package:e_commerce_app/domain/Entity/banners_entity.dart';
import 'package:e_commerce_app/domain/Entity/category_entity.dart';
import 'package:e_commerce_app/domain/Entity/get_favourites_entity.dart';
import 'package:e_commerce_app/domain/Entity/home_entity.dart';
import 'package:e_commerce_app/domain/use_cases/get_banners_usecase.dart';
import 'package:e_commerce_app/domain/use_cases/get_categories_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/get_favourites_usecase.dart';
import 'package:e_commerce_app/domain/use_cases/get_products_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/post_addOrDeleteFavourites.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/flutter_toast.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  late List<BannersEntity> bannersModel = [];
  void getBanners() {
    emit(GetBannersLoadingtate());
    GetBannersUseCase(sl()).call(const NoParameter()).then((value) {
      value.fold(
        (l) => ServerFailure(l.message),
        (r) => bannersModel = r,
      );
      emit(GetBannersSuccessState());
    }).catchError((error) {
      emit(GetBannersFailedtate());
    });
  }

  Map<int, bool> favorites = {};

  HomeEntity? homeModel;
  Future<void> getProducts(String token,
      {String? page /* in case of using pagination*/}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(GetProductsLoadingState());
    await GetHomeProductsUseCase(baseRepository: sl())
        .call(ProductsParameter(token: prefs.getString('token') ?? ''))
        .then(
      (value) {
        value.fold((l) => ServerFailure(l.message), (r) => homeModel = r);

        for (var element in homeModel!.data.products) {
          favorites.addAll({element.id: element.in_favorites});
        }
        emit(GetProductsSuccessState());
      },
    ).catchError((error) {
      emit(GetProductsErrorState());
    });
  }

  CategoryEntity? categoryModel;
  CategoryModel? m;
  void getCategories() {
    emit(GetCategoriesLoadingState());
    GetCategoryUseCase(baseRepository: sl())
        .call(const NoParameter())
        .then((value) {
      // todo if category failed return it to categoryEntity;
      value.fold((l) => l.message, (r) => categoryModel = r);
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      emit(GetCategoriesErrorState());
    });
  }



  AddOrDeleteFavouritesEntity? addOrDeleteFavouritesEntity;

  void changeFavouriteState(int id, String token) {
    favorites[id] = !favorites[id]!;
    emit(ChangeFavouriteSuccessState());
    AddOrDeleteFavouritesUseCase(baseRepository: sl())
        .call(AddOrDeleteFavouritesParameters(id, token))
        .then((value) {
      value.fold((l) => l.message, (r) => addOrDeleteFavouritesEntity = r);
      if (!addOrDeleteFavouritesEntity!.status) {
        favorites[id] = !favorites[id]!;
        showToast(
          msg: addOrDeleteFavouritesEntity?.message ?? "somthing is wrong",
          states: ToastStates.errorState,
        );
      } else {
        getFavourites(token);
        showToast(
          msg: addOrDeleteFavouritesEntity?.message ?? "somthing is wrong",
          states: ToastStates.successState,
        );
      }
      emit(ChangeFavouriteSuccessState());
    }).catchError((error) {
      favorites[id] = !favorites[id]!;
      emit(ChangeFavouriteErrorState());
    });
  }

  GetFavouritesEntity? getFavouritesEntity;
  void getFavourites(String token) {
    emit(GetFavouriteLoadingState());
    GetFavouritesUseCase(baseRepository: sl())
        .call(GetFavouritesParameters(token))
        .then(
      (value) {
        value.fold((l) => l.message, (r) => getFavouritesEntity = r);
        emit(GetFavouriteSuccessState());
      },
    ).catchError(
      (error) {
        emit(GetFavouriteErrorState());
      },
    );
  }
}

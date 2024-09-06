import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/data/models/category_model.dart';
import 'package:e_commerce_app/domain/Entity/add&delete_favourites_entity.dart';
import 'package:e_commerce_app/domain/Entity/add_to_cart.dart';
import 'package:e_commerce_app/domain/Entity/banners_entity.dart';
import 'package:e_commerce_app/domain/Entity/category_entity.dart';
import 'package:e_commerce_app/domain/Entity/get_favourites_entity.dart';
import 'package:e_commerce_app/domain/Entity/home_entity.dart';
import 'package:e_commerce_app/domain/use_cases/add_to_car_usecase.dart';
import 'package:e_commerce_app/domain/use_cases/get_banners_usecase.dart';
import 'package:e_commerce_app/domain/use_cases/get_categories_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/get_favourites_usecase.dart';
import 'package:e_commerce_app/domain/use_cases/get_products_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/post_addOrDeleteFavourites.dart';
import 'package:e_commerce_app/presentation/controller/home_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/flutter_toast.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit({
    required this.getBannersUseCase,
    required this.addToCartUsecase,
  }) : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  late List<BannersEntity> bannersModel = [];
  GetBannersUseCase getBannersUseCase;
  void getBanners() async {
    emit(GetBannersLoadingtate());
    var res = await getBannersUseCase.call(const NoParameter());
    res.fold((l) {
      emit(GetBannersFailedtate(message: l.message));
    }, (r) {
      bannersModel = r;
      emit(GetBannersSuccessState());
    });
  }

  Map<int, bool> favorites = {};

  HomeEntity? homeModel;
  Future<void> getProducts(
      {String? page /* in case of using pagination*/}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(GetProductsLoadingState());
    await GetHomeProductsUseCase(baseRepository: sl())
        .call(const NoParameter())
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

  void changeFavouriteState(int id) {
    favorites[id] = !favorites[id]!;
    emit(ChangeFavouriteSuccessState());
    AddOrDeleteFavouritesUseCase(baseRepository: sl())
        .call(AddOrDeleteFavouritesParameters(id))
        .then((value) {
      value.fold((l) => l.message, (r) => addOrDeleteFavouritesEntity = r);
      if (!addOrDeleteFavouritesEntity!.status) {
        favorites[id] = !favorites[id]!;
        showToast(
          msg: addOrDeleteFavouritesEntity?.message ?? "somthing is wrong",
          states: ToastStates.errorState,
        );
      } else {
        getFavourites();
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
  void getFavourites() {
    emit(GetFavouriteLoadingState());
    GetFavouritesUseCase(baseRepository: sl()).call(const NoParameter()).then(
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

  AddToCartUsecase addToCartUsecase;
  AddToCartEntity? addToCartEntity;
  void addToCart(int productId) async {
    emit(AddToCartLoadingState());
    var res = await addToCartUsecase.call(
      AddToCartParameters(
        productId: productId,
      ),
    );
    res.fold(
      (l) {
        emit(
          AddToCartErrorState(message: l.message),
        );
      },
      (r) {
        addToCartEntity = r;
        emit(AddToCartSuccessState());
      },
    );
  }
}

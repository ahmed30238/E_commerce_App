abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class GetBannersSuccessState extends HomeStates {}

class GetBannersLoadingtate extends HomeStates {}

class GetBannersFailedtate extends HomeStates {
  final String message;

  GetBannersFailedtate({required this.message});
}

class GetProductsSuccessState extends HomeStates {}

class GetProductsLoadingState extends HomeStates {}

class GetProductsErrorState extends HomeStates {}

class GetCategoriesSuccessState extends HomeStates {}

class GetCategoriesLoadingState extends HomeStates {}

class GetCategoriesErrorState extends HomeStates {}

class ChangeFavouriteSuccessState extends HomeStates {}

class ChangeFavouriteErrorState extends HomeStates {}

class GetFavouriteSuccessState extends HomeStates {}

class GetFavouriteLoadingState extends HomeStates {}

class GetFavouriteErrorState extends HomeStates {}


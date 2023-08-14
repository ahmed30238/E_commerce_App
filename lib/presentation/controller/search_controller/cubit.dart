import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/domain/Entity/search_entity.dart';
import 'package:e_commerce_app/domain/use_cases/post_search_usecase.dart';
import 'package:e_commerce_app/presentation/controller/search_controller/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchEntity? searchEntity;

  void postSearch(String text) {
    emit(SearchLoadingState());
    PostSearchUseCase(baseRepository: sl()).call(SearchParameters(text)).then(
      (value) {
        value.fold(
          (l) => l.message,
          (r) => searchEntity = r,
        );
        emit(SearchSuccessState());
      },
    ).catchError(
      (error) {
        emit(SearchErrorState());
      },
    );
  }
}

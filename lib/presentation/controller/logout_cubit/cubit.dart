import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/domain/Entity/logout_entity.dart';
import 'package:e_commerce_app/domain/use_cases/post_logout_usecase.dart';
import 'package:e_commerce_app/presentation/controller/logout_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutStates> {
  LogoutCubit() : super(LogoutInitialState());

  static LogoutCubit get(context) => BlocProvider.of(context);

  LogoutEntity? logoutEntity;
  Future<void> postLogout(String token) async {
    emit(PostLogoutDataLoadingState());
    return LogoutUseCase(baseRepository: sl())
        .call(LogoutParameters(token))
        .then(
      (value) {
        value.fold(
          (l) => l.message,
          (r) => logoutEntity = r,
        );
        emit(PostLogoutDataSuccessState());
      },
    ).catchError((error) {
      emit(PostLogoutDataFailedState());
    });
  }
}

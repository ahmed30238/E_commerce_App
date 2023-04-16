import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/domain/Entity/login.dart';
import 'package:e_commerce_app/domain/use_cases/post_login_data.dart';
import 'package:e_commerce_app/presentation/controller/login_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<Loginstates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool passwordVisibility = true;
  void changeVisibility() {
    passwordVisibility = !passwordVisibility;
    emit(PasswordVisibilityState());
  }

  LoginEntity? loginModel;
  Future<void> postLoginData(
    String email,
    String password,
  ) {
    emit(PostLoginDataLoadingState());
    return PostLoginDataUseCase(baseRepository: sl())
        .call(
      LoginParameters(
        email: email,
        password: password,
      ),
    )
        .then((value) {
      value.fold(
        (l) => ServerFailure(loginModel!.message),
        (r) => loginModel = r,
      );
      emit(PostLoginDataSuccessState());
    }).catchError((error) {
      emit(PostLoginDataFailedState());
    });
  }
}

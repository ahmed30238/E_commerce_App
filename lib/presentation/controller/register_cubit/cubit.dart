import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/domain/Entity/register_entity.dart';
import 'package:e_commerce_app/domain/use_cases/post_register_data_usecase.dart';
import 'package:e_commerce_app/presentation/controller/register_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool passwordVisibility = true;
  void changeVisibility() {
    passwordVisibility = !passwordVisibility;
    emit(PasswordVisibilityState());
  }

  RegisterEntity? registerEntity;
  Future<void> postRegisterData(
      String email, String password, String name, String phone) {
    emit(PostRegisterDataLoadingState());
  return  PostRegisterDataUseCase(baseRepository: sl())
        .call(RegisterDataParameters(name, password, email, phone))
        .then((value) {
      value.fold((l) => l.message, (r) => registerEntity = r);
      emit(PostRegisterDataSuccessState());
    }).catchError(
      (error) {
        emit(PostRegisterDataFailedState());
      },
    );
  }
}

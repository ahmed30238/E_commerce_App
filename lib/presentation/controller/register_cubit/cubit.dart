import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/core/token_util/token_utile.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/domain/Entity/register_entity.dart';
import 'package:e_commerce_app/domain/use_cases/post_register_data_usecase.dart';
import 'package:e_commerce_app/presentation/components/flutter_toast.dart';
import 'package:e_commerce_app/presentation/controller/register_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this.postRegisterDataUseCase) : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool passwordVisibility = true;
  void changeVisibility() {
    passwordVisibility = !passwordVisibility;
    emit(PasswordVisibilityState());
  }

  RegisterEntity? registerEntity;
  PostRegisterDataUseCase postRegisterDataUseCase;
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> postRegisterData() async {
    emit(PostRegisterDataLoadingState());

    var res = await postRegisterDataUseCase.call(
      RegisterDataParameters(
        nameController.text,
        passwordController.text,
        emailController.text,
        phoneController.text,
      ),
    );

    res.fold((l) {
      emit(PostRegisterDataFailedState(l.message));
    }, (r) {
      registerEntity = r;
      emit(PostRegisterDataSuccessState());
    });
  }

  dialogMethod(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator.adaptive(
              backgroundColor: Colors.orange,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            10.ph,
            const Text(AppStrings.welcome),
          ],
        ),
      ),
    );
  }

  verificationMetod({required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus;
      dialogMethod(context);
      await postRegisterData();

      if (registerEntity?.status == true) {
        TokenUtil.saveToken(registerEntity?.registerData.token ?? "").then(
          (value) => Navigator.pushNamedAndRemoveUntil(
            context,
            RoutePaths.layoutScreen,
            (route) => false,
          ),
        );
        showToast(
            msg: registerEntity?.message ?? "",
            states: ToastStates.successState);
      } else {
        showToast(
          msg: registerEntity!.message,
          states: ToastStates.errorState,
        );
      }
    }
  }
}

import 'package:e_commerce_app/domain/Entity/change_password.dart';
import 'package:e_commerce_app/domain/use_cases/change_password_usecase.dart';
import 'package:e_commerce_app/presentation/components/flutter_toast.dart';
import 'package:e_commerce_app/presentation/controller/change_password_cubit/changepassword_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangepasswordCubit extends Cubit<ChangepasswordState> {
  ChangepasswordCubit(this.changePasswordUsecase)
      : super(ChangepasswordInitial());

  final ChangePasswordUsecase changePasswordUsecase;
  static ChangepasswordCubit get(context) => BlocProvider.of(context);
  final TextEditingController currentPasword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ChangePasswordEntity? changePasswordEntity;
  bool isLoading = false;
  void changePassword() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      emit(ChangepasswordLoading());
      var res = await changePasswordUsecase.call(
        ChangePasswordParameters(
          currentPasword: currentPasword.text,
          newPassword: newPassword.text,
        ),
      );
      res.fold((l) {
        isLoading = false;
        emit(
          ChangepasswordError(
            message: l.message,
          ),
        );
        showToast(msg: l.message, states: ToastStates.successState);
      }, (r) {
        changePasswordEntity = r;
        isLoading = false;
        emit(ChangepasswordSuccess());
        showToast(msg: r.message, states: ToastStates.successState);
      });
    }
  }

  bool isHidden = true;
  void changeVisibility() {
    isHidden = !isHidden;
    emit(ChangepasswordVisibiltyState());
  }
}

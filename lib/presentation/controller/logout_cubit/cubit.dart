import 'package:e_commerce_app/core/global/app_enums/enums.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/domain/Entity/logout_entity.dart';
import 'package:e_commerce_app/domain/use_cases/post_logout_usecase.dart';
import 'package:e_commerce_app/presentation/components/flutter_toast.dart';
import 'package:e_commerce_app/presentation/controller/logout_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutStates> {
  LogoutCubit(this.logoutUseCase) : super(LogoutInitialState());

  static LogoutCubit get(context) => BlocProvider.of(context);

  LogoutEntity? logoutEntity;
  LogoutUseCase logoutUseCase;
  void postLogout(String fcmToken, BuildContext context) async {
    emit(PostLogoutDataLoadingState());

    var res = await logoutUseCase.call(LogoutParameters(fcmToken));

    res.fold((l) {
      emit(PostLogoutDataFailedState(message: l.message));
      print(l.message.toString());
    }, (r) {
      logoutEntity = r;
      emit(PostLogoutDataSuccessState());
    });
    Future.delayed(Duration.zero, () {
      removeTokenAfterLogut(context);
      showToast(
        msg: LogoutCubit.get(context).logoutEntity!.message,
        states: ToastStates.successState,
      );
    });
  }

  removeTokenAfterLogut(BuildContext context) {
    prefs?.remove(AppEnum.token.name).then((value) {
      Navigator.pushNamed(context, RoutePaths.loginScreen);
    });
  }
}

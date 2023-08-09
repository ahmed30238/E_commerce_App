import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/core/network_call/network_call.dart';
import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/core/token_util/token_utile.dart';
import 'package:e_commerce_app/data/models/login_model.dart';
import 'package:e_commerce_app/domain/Entity/login.dart';
import 'package:e_commerce_app/domain/use_cases/post_login_data.dart';
import 'package:e_commerce_app/presentation/controller/login_cubit/states.dart';
import 'package:e_commerce_app/presentation/screens/layout/layout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quick_log/quick_log.dart';

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

  // todo need to be fixed
  Logger logger = const Logger("Login Logger");
  Future<void> signInWithGoogleAccount({required BuildContext context}) async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      var auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithCredential(credential);
      logger.info(userCredential.user?.email);
      logger.info(userCredential.user?.uid);
      final res = await NetworkCall().post(
        "https://student.valuxapps.com/api/login",
        body: FormData.fromMap(
          {
            "email": userCredential.user?.email,
            "password": "aaaa",
          },
        ),
      );
      if (res?.statusCode == 200) {
        loginModel = LoginModel.fromjson(res?.data);
        cacheUserData(loginModel!, context: context);
      }
      logger.debug("res from login data ${loginModel?.loginData?.token}");

      // PostLoginDataUseCase(baseRepository: sl())
      //     .call(
      //   LoginParameters(
      //     email: userCredential.user?.displayName ?? "",
      //     password: userCredential.user?.displayName ?? "",
      //   ),
      // )
      //     .then((value) {
      //   value.fold(
      //     (l) => ServerFailure(loginModel!.message),
      //     (r) => loginModel = r,
      //   );
      // });
      // cacheUserData(loginModel!, context: context);
      logger.fine(loginModel?.loginData?.name);
      logger.fine(loginModel?.loginData);
    } catch (error) {
      logger.error(error);
    }
  }
}

class StorageEnum {
  static const String isGuest = 'isGuest';
  static const String userData = 'userData';
  static const String seenAdvList = 'seenAdvList';
}

void cacheUserData(
  LoginEntity data, {
  String? alternativeNamedRouteAfterCacheSuccess,
  required BuildContext context,
}) {
  prefs?.setString(StorageEnum.userData, jsonEncode(data.loginData));
  TokenUtil.saveToken(data.loginData?.token ?? '');
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LayOutScreen(),
      ));
  prefs?.setBool(StorageEnum.isGuest, false);
}

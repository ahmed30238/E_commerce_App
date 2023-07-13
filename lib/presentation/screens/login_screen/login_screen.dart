import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/core/token_util/token_utile.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/components/flutter_toast.dart';
import 'package:e_commerce_app/presentation/components/text_field.dart';
import 'package:e_commerce_app/presentation/controller/login_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/login_cubit/states.dart';
import 'package:e_commerce_app/core/extensions/sizes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, Loginstates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          void tryToLogin() {
            if (_formKey.currentState!.validate()) {
              FocusManager.instance.primaryFocus?.unfocus;
              // showDialog(
              //   barrierDismissible: false,
              //   context: context,
              //   builder: (context) => AlertDialog(
              //     content: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         const CircularProgressIndicator.adaptive(
              //           backgroundColor: Colors.orange,
              //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //         ),
              //         10.ph,
              //         const Text(AppStrings.loggingIn),
              //       ],
              //     ),
              //   ),
              // );
              cubit
                  .postLoginData(
                _emailController.text,
                _passwordController.text,
              )
                  .then(
                (value) async {
                  if (cubit.loginModel!.status) {
                    TokenUtil.saveToken(cubit.loginModel!.loginData!.token);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs
                        .setString('token', cubit.loginModel!.loginData!.token)
                        .then(
                          (value) => navigateAndRemove(
                              context: context, path: RoutePaths.layoutScreen),
                        );

                    showToast(
                      msg: cubit.loginModel!.message,
                      states: ToastStates.successState,
                    );
                  } else {
                    showToast(
                      msg: cubit.loginModel!.message,
                      states: ToastStates.errorState,
                    );
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                      return;
                    }
                  }
                },
              );
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
                return;
              }
            }
          }

          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.grey[300],
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(215, 117, 255, 1).withOpacity(.5),
                    const Color.fromRGBO(240, 188, 117, 1).withOpacity(.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.deepOrange.shade400,
                            borderRadius: BorderRadius.circular(15)),
                        transform: Matrix4.rotationZ(-.2),
                        child: const Center(
                          child: Text(
                            AppStrings.appName,
                            style: TextStyle(
                                fontFamily: AppStrings.myFont1,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      40.ph,
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     gradient: LinearGradient(
                      //       colors: [
                      //         Color.fromRGBO(25, 25, 25, 1),
                      //         Color.fromRGBO(25, 25, 25, 1),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      CustomFormField(
                        label: AppStrings.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.emailValidationMessage;
                          }
                          return null;
                        },
                        controller: _emailController,
                        suffixIcon: Icons.email,
                      ),
                      30.ph,
                      CustomFormField(
                        obscureText: cubit.passwordVisibility,
                        label: AppStrings.password,
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.passwordValidationMessage;
                          }
                          return null;
                        },
                        suffixIcon: Icons.remove_red_eye_rounded,
                        onTap: cubit.changeVisibility,
                      ),
                      20.ph,
                      CustomElevatedButton(
                        onTap: tryToLogin,
                        text: AppStrings.login,
                        textColor: Theme.of(context).colorScheme.primary,
                        fontFamily: AppStrings.myFont1,
                        btnColor: Theme.of(context).colorScheme.background,
                        borderColor: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      10.ph,
                      RichText(
                        text: TextSpan(
                          text: "${AppStrings.haveAccountVerification}  ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: AppStrings.registerNow,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => navigateTo(
                                      context: context,
                                      path: RoutePaths.registerScreen,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

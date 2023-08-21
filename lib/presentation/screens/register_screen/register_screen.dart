import 'package:e_commerce_app/core/extensions/strins_extension.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/core/token_util/token_utile.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/components/flutter_toast.dart';
import 'package:e_commerce_app/presentation/components/text_field.dart';
import 'package:e_commerce_app/presentation/controller/register_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/register_cubit/states.dart';
import 'package:e_commerce_app/presentation/screens/layout/layout_screen.dart';
import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      20.ph,
                      CustomFormField(
                        controller: nameController,
                        label: AppStrings.name,
                        suffixIcon: Icons.person,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.nameValidationMessage;
                          }
                          return null;
                        },
                      ),
                      10.ph,
                      CustomFormField(
                        onTap: () {},
                        controller: phoneController,
                        label: AppStrings.phone,
                        suffixIcon: Icons.phone,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.phoneValidationMessage;
                          }
                          return null;
                        },
                      ),
                      10.ph,
                      CustomFormField(
                        onTap: () {},
                        controller: emailController,
                        label: AppStrings.email,
                        suffixIcon: Icons.email,
                        validator: (value) => (value?.emailValidation() ?? true)
                            ? null
                            : "Not Valid",
                      ),
                      10.ph,
                      CustomFormField(
                        onTap: () {
                          RegisterCubit.get(context).changeVisibility();
                        },
                        obscureText:
                            RegisterCubit.get(context).passwordVisibility,
                        controller: passwordController,
                        label: AppStrings.password,
                        suffixIcon: Icons.remove_red_eye,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.passwordValidationMessage;
                          }
                          return null;
                        },
                      ),
                      20.ph,
                      CustomElevatedButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus;
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.orange,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                    10.ph,
                                    const Text(AppStrings.welcome),
                                  ],
                                ),
                              ),
                            );
                            cubit
                                .postRegisterData(
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                    phoneController.text)
                                .then(
                              (value) async {
                                if (cubit.registerEntity!.status) {
                                  TokenUtil.saveToken(cubit.registerEntity
                                              ?.registerData.token ??
                                          "")
                                      .then(
                                    (value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LayOutScreen(),
                                      ),
                                    ),
                                  );

                                  // SharedPreferences prefs =
                                  //     await SharedPreferences.getInstance();
                                  // prefs
                                  //     .setString(
                                  //         'token',
                                  //         cubit.registerEntity!.registerData
                                  //             .token)
                                  //     .then((value) =>
                                  //        );

                                  showToast(
                                      msg: cubit.registerEntity!.message,
                                      states: ToastStates.successState);
                                } else {
                                  showToast(
                                    msg: cubit.registerEntity!.message,
                                    states: ToastStates.errorState,
                                  );
                                }
                              },
                            );
                          }
                        },
                        text: AppStrings.signUp,
                        textColor: Theme.of(context).colorScheme.primary,
                        borderColor: Colors.white,
                        btnColor: Theme.of(context).colorScheme.background,
                        fontFamily: AppStrings.myFont1,
                      ),
                      10.ph,
                      RichText(
                        text: TextSpan(
                          text: "${AppStrings.alreadyHaveAnAccount}  ",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: AppStrings.signIn,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => navigateTo(
                                      context: context,
                                      path: RoutePaths.loginScreen,
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

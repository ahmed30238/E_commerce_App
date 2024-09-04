import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:e_commerce_app/core/extensions/strings_extension.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/core/routing/routing_paths.dart';
import 'package:e_commerce_app/core/service_locator/service_locator.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/components/text_field.dart';
import 'package:e_commerce_app/presentation/controller/register_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/register_cubit/states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(sl()),
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
                  key: cubit.formKey,
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
                        controller: cubit.nameController,
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
                        controller: cubit.phoneController,
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
                        controller: cubit.emailController,
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
                        controller: cubit.passwordController,
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
                          cubit.verificationMetod(context: context);
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

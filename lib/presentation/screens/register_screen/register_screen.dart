import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/components/flutter_toast.dart';
import 'package:e_commerce_app/presentation/components/text_field.dart';
import 'package:e_commerce_app/presentation/controller/register_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/register_cubit/states.dart';
import 'package:e_commerce_app/presentation/screens/layout/layout_screen.dart';
import 'package:e_commerce_app/presentation/screens/login_screen/login_screen.dart';
import 'package:e_commerce_app/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: const Text(
                            AppStrings.name,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 20,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.person),
                            onPressed: () {},
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.nameValidationMessage;
                          }
                          return null;
                        },
                      ),
                      10.ph,
                      defaultTextFormField(
                        onTap: () {},
                        isPassword: false,
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
                      defaultTextFormField(
                        onTap: () {},
                        isPassword: false,
                        controller: emailController,
                        label: AppStrings.email,
                        suffixIcon: Icons.email,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.emailValidationMessage;
                          }
                          return null;
                        },
                      ),
                      10.ph,
                      defaultTextFormField(
                        onTap: () {
                          RegisterCubit.get(context).changeVisibility();
                        },
                        isPassword:
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
                      defaultButton(
                        context: context,
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
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs
                                      .setString(
                                          'token',
                                          cubit.registerEntity!.registerData
                                              .token)
                                      .then((value) =>
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LayOutScreen())));

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
                        textColor: Colors.white,
                        borderColor: Colors.deepOrange,
                        containerColor: Colors.deepOrange,
                      ),
                      10.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            AppStrings.alreadyHaveAnAccount,
                            style: TextStyle(color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: const Text(
                              AppStrings.signIn,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
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

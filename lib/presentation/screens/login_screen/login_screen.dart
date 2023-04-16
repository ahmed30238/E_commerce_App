import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/components/flutter_toast.dart';
import 'package:e_commerce_app/presentation/controller/login_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/login_cubit/states.dart';
import 'package:e_commerce_app/presentation/screens/layout/layout_screen.dart';
import 'package:e_commerce_app/presentation/screens/register_screen/register_screen.dart';
import 'package:e_commerce_app/sizes.dart';
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
                      const Text(AppStrings.loggingIn),
                    ],
                  ),
                ),
              );
              cubit
                  .postLoginData(
                _emailController.text,
                _passwordController.text,
              )
                  .then(
                (value) async {
                  if (cubit.loginModel!.status) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs
                        .setString('token', cubit.loginModel!.loginData!.token)
                        .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LayOutScreen())));

                    showToast(
                        msg: cubit.loginModel!.message,
                        states: ToastStates.successState);
                  } else {
                    showToast(
                      msg: cubit.loginModel!.message,
                      states: ToastStates.errorState,
                    );
                    Navigator.pop(context);
                  }
                },
              );
            }
          }

          return Scaffold(
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
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(
                                25,
                                25,
                                25,
                                1,
                              ),
                              Color.fromRGBO(
                                25,
                                25,
                                25,
                                1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            AppStrings.email,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 20,
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.emailValidationMessage;
                          }
                          return null;
                        },
                      ),
                      30.ph,
                      TextFormField(
                        obscureText: cubit.passwordVisibility,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: const Text(
                            AppStrings.password,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 20,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_red_eye_rounded),
                            onPressed: () {
                              cubit.changeVisibility();
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.passwordValidationMessage;
                          }
                          return null;
                        },
                      ),
                      20.ph,
                      defaultButton(
                          onTap: tryToLogin,
                          text: AppStrings.login,
                          context: context,
                          fontFamily: AppStrings.myFont1,
                          containerColor: Colors.deepOrange,
                          borderColor: Colors.transparent,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                  
                      10.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            AppStrings.haveAccountVerification,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              AppStrings.registerNow,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      )
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

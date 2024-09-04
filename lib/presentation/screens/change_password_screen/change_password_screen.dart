import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/components/text_field.dart';
import 'package:e_commerce_app/presentation/controller/change_password_cubit/changepassword_cubit.dart';
import 'package:e_commerce_app/presentation/controller/change_password_cubit/changepassword_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ChangepasswordCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: cubit.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<ChangepasswordCubit, ChangepasswordState>(
                builder: (context, state) => CustomFormField(
                  controller: cubit.currentPasword,
                  obscureText: cubit.isHidden,
                  label: 'current password',
                  onTap: cubit.changeVisibility,
                  suffixIcon: Icons.remove_red_eye_rounded,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "required field";
                    }
                    return null;
                  },
                ),
              ),
              20.ph,
              BlocBuilder<ChangepasswordCubit, ChangepasswordState>(
                builder: (context, state) => CustomFormField(
                  controller: cubit.newPassword,
                  obscureText: cubit.isHidden,
                  label: 'new password',
                  onTap: cubit.changeVisibility,
                  suffixIcon: Icons.phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "required field";
                    }
                    return null;
                  },
                ),
              ),
              20.ph,
              BlocBuilder<ChangepasswordCubit, ChangepasswordState>(
                builder: (context, state) => CustomElevatedButton(
                  loading: cubit.isLoading,
                  text: 'Change Password',
                  textColor: Colors.white,
                  onTap: cubit.changePassword,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/components/text_field.dart';
import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomFormField(
              controller: nameController,
              label: 'name',
              onTap: () {},
              suffixIcon: Icons.person,
              validator: (String? value) {
                return null;
              },
            ),
            20.ph,
            CustomFormField(
              controller: phoneController,
              label: 'phone',
              onTap: () {},
              suffixIcon: Icons.phone,
              validator: (String? value) {
                return null;
              },
            ),
            20.ph,
            CustomFormField(
              controller: emailControler,
              label: 'email',
              onTap: () {},
              suffixIcon: Icons.email,
              validator: (String? value) {
                return null;
              },
            ),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomElevatedButton(
                  onTap: () {},
                  text: 'text',
                ),
                10.pw,
                CustomElevatedButton(
                  text: 'btn',
                  onTap: () => log('pressed'),
                ),
                // defaultButton(
                //   onTap: () {},
                //   text: 'update',
                //   context: context,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

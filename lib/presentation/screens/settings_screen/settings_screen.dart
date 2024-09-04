import 'package:e_commerce_app/core/extensions/locale_context.dart';
import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:e_commerce_app/core/global/app_enums/enums.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/core/utils/app_constances/app_constances.dart';
import 'package:e_commerce_app/core/utils/app_strings/app_strings.dart';
import 'package:e_commerce_app/presentation/components/default_button.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/states.dart';
import 'package:e_commerce_app/presentation/controller/logout_cubit/cubit.dart';
import 'package:e_commerce_app/presentation/screens/content_screen/content_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../change_password_screen/change_password_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var image;
    List<NotificationsSettingsListModel> notificationsList = [
      NotificationsSettingsListModel(
        AppStrings.themeDark,
        CupertinoSwitch(
          value: AppCubit.get(context).theme,
          onChanged: (value) {
            AppCubit.get(context).toggleTheme();
          },
        ),
      ),
      NotificationsSettingsListModel(
        AppStrings.accountActivate,
        Switch(value: true, onChanged: (value) {}),
      ),
      NotificationsSettingsListModel(
        AppStrings.opportunity,
        Switch(value: true, onChanged: (value) {}),
      ),
    ];
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            25.ph,
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                5.pw,
                Text(
                  AppStrings.account,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
            6.ph,
            const Divider(color: Colors.grey, height: 2),
            20.ph,
            SizedBox(
              height: 200,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    accountSettingsItem(settingsList[index], context),
                separatorBuilder: (context, index) => 15.ph,
                itemCount: settingsList.length,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                5.pw,
                Text(
                  AppStrings.notification,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
            6.ph,
            const Divider(color: Colors.grey, height: 5),
            20.ph,
            SizedBox(
              height: 200.h,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    notificationSettingsItem(notificationsList[index], context),
                separatorBuilder: (context, index) => 15.ph,
                itemCount: notificationsList.length,
              ),
            ),
            10.ph,
            CustomElevatedButton(
              borderColor: Colors.white,
              text: AppStrings.signOut,
              textColor: Theme.of(context).colorScheme.onBackground,
              btnColor: Theme.of(context).colorScheme.primary,
              onTap: () async {
                var logoutCubit = LogoutCubit.get(context);

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Logout"),
                    content: Text(context.loc?.logutMssage ?? ""),
                    actions: [
                      InkWell(
                        onTap: () => logoutCubit.postLogout(
                          prefs?.getString(AppEnum.fcmToken.name) ?? "",
                          context,
                        ),
                        child: context.mediumText(
                          text: "Yes",
                          color: Colors.red,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                         child: context.mediumText(
                          text: "No",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IconButton(
                //   onPressed: () async {
                //     var player = AudioPlayer();
                //     await player.play(
                //       AssetSource(
                //         "sound/send.mp3",
                //       ),
                //     );
                //     // player
                //     //     .setAsset("assets/sound/send.mp3")
                //     //     .then((value) => player.play());
                //     //  player.play
                //     // urlLauncher("https://www.facebook.com/");
                //   },
                //   icon: const Icon(
                //     Icons.telegram_sharp,
                //   ),
                // ),
                // IconButton(
                //   onPressed: () {
                //     showImagePicker(
                //       context: context,
                //       onCameraTapped: pickImageFromCamera,
                //       onGalleryTapped: pickImageFromGallery,
                //     );
                //   },
                //   icon: const Icon(
                //     Icons.image,
                //   ),
                // ),
                IconButton(
                  onPressed: () {
                    Share.share(
                      AppConstances.appUrl,
                    );
                  },
                  icon: const Icon(Icons.share),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccountSettingsListModel {
  final String text;
  final IconData icon;
  final int pageId;

  const AccountSettingsListModel(
    this.text,
    this.icon,
    this.pageId,
  );
}

List<AccountSettingsListModel> settingsList = [
  const AccountSettingsListModel(
    AppStrings.changePassword,
    Icons.arrow_forward_ios,
    0,
  ),
  const AccountSettingsListModel(
    AppStrings.content,
    Icons.arrow_forward_ios,
    1,
  ),
  const AccountSettingsListModel(
    AppStrings.social,
    Icons.arrow_forward_ios,
    2,
  ),
  const AccountSettingsListModel(
    AppStrings.language,
    Icons.arrow_forward_ios,
    3,
  ),
  const AccountSettingsListModel(
    AppStrings.privacyAndSecurity,
    Icons.arrow_forward_ios,
    4,
  ),
];

List<Widget> settingsScreen = [
  ChangePasswordScreen(),
  const ContentScreen(),
  const ContentScreen(),
  const ContentScreen(),
  const ContentScreen(),
];
Widget accountSettingsItem(AccountSettingsListModel model, context) {
  int index = model.pageId;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: InkWell(
      onTap: () {
        index == 3
            ? changeLangDailog(context)
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => settingsScreen[index],
                ),
              );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            model.text,
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            model.icon,
            color: Colors.grey[500],
          )
        ],
      ),
    ),
  );
}

class NotificationsSettingsListModel {
  final String text;
  final Widget widget;

  const NotificationsSettingsListModel(
    this.text,
    this.widget,
  );
}

Widget notificationSettingsItem(
  NotificationsSettingsListModel model,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            model.text,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          model.widget,
        ],
      ),
    ),
  );
}

changeLangDailog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);

          return AlertDialog(
            content: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 130,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        cubit.storeLanguage(langCode: 'ar');
                        Navigator.pop(context);
                      },
                      child: IgnorePointer(
                        child: Row(
                          children: [
                            Checkbox(
                              autofocus: true,
                              splashRadius: 20,
                              tristate: true,
                              shape: const CircleBorder(
                                side: BorderSide(width: 2),
                              ),
                              value: !cubit.isEnglishLang(context: context),
                              // activeColor: MainColors.primaryColor,
                              onChanged: (value) {},
                            ),
                            const Text('العربية'
                                // style: MainTextStyle.boldTextStyle(
                                //     fontSize: 20,
                                //     color: MainColors.primaryColor),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const HorizontalDivider(),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        cubit.storeLanguage(langCode: 'en');
                        Navigator.pop(context);
                      },
                      child: IgnorePointer(
                        child: Row(
                          children: [
                            // Radio(value: true, groupValue: RadioButtonInputElement(), onChanged: (value){}),
                            Checkbox(
                              tristate: true,
                              shape: const CircleBorder(eccentricity: 0),
                              value: cubit.isEnglishLang(context: context),
                              onChanged: (value) {},
                            ),
                            const Text('English'
                                // style: MainTextStyle.boldTextStyle(
                                //     fontSize: 20,
                                //     color: MainColors.primaryColor),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

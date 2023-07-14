import 'dart:developer';

import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';
import 'package:e_commerce_app/core/token_util/theme_mode.dart';
import 'package:e_commerce_app/presentation/controller/layout_cubit/states.dart';
import 'package:e_commerce_app/presentation/screens/categories/categories_screen.dart';
import 'package:e_commerce_app/presentation/screens/favourites_screen.dart/favourites_screen.dart';
import 'package:e_commerce_app/presentation/screens/home_screen/home_screen.dart';
import 'package:e_commerce_app/presentation/screens/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    const SettingsScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavigationBarItems = const [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(
        Icons.home,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Categories',
      icon: Icon(
        // color: Colors.black,
        Icons.category_outlined,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Favourites',
      icon: Icon(
        // color: Colors.black,
        Icons.favorite,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Settings',
      icon: Icon(
        Icons.settings,
      ),
    ),
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  var theme = ThemeUtils.getTheme();
  toggleTheme() async {
    theme = !theme;
    await ThemeUtils.saveThemeMode(theme);
    emit(ChangeThemeModeSucessState());
  }

  final String langKey = "";
  void storeLanguage({required String langCode}) async {
    prefs!.setString(langKey, langCode);
    await getLanguage();
    emit(AppChangeLanguage(locale: langCode));
  }

  String? localeCode = 'en';
  Future<void> getLanguage() async {
    localeCode = prefs!.getString(langKey);
    log('lang is $localeCode');
    emit(AppChangeLanguage(locale: localeCode ?? 'en'));
  }

  bool isEnglishLang({required BuildContext context}) =>
      Localizations.localeOf(context).languageCode == 'en';
}

import 'package:e_commerce_app/presentation/controller/layout_cubit/states.dart';
import 'package:e_commerce_app/presentation/screens/categories/categories_screen.dart';
import 'package:e_commerce_app/presentation/screens/favourites_screen.dart/favourites_screen.dart';
import 'package:e_commerce_app/presentation/screens/home_screen/home_screen.dart';
import 'package:e_commerce_app/presentation/screens/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        // color: Colors.black,
        Icons.settings,
      ),
    ),
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  bool isDarkTheme = false;

  void changeThemeMode({bool? fromShared}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (fromShared != null) {
      isDarkTheme = fromShared;
      emit(ChangeThemeModeSucessState());
    } else {
      isDarkTheme = !isDarkTheme;
      prefs.setBool('isDarkTheme', isDarkTheme).then((value) {
        emit(ChangeThemeModeSucessState());
      });
    }
  }
  // void changeThemeMode()async{
  //   isDarkTheme = !isDarkTheme;
  //   emit(ChangeThemeModeState());
  //   print('in cubit $isDarkTheme');
  // }
}

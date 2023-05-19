abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeBottomNavBarState extends AppStates {}

class ChangeThemeModeSucessState extends AppStates {}

class AppChangeLanguage extends AppStates {
  final String locale;

  AppChangeLanguage({required this.locale});
}

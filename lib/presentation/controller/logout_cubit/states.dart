abstract class LogoutStates {}

class LogoutInitialState extends LogoutStates {}

class PostLogoutDataSuccessState extends LogoutStates {}

class PostLogoutDataFailedState extends LogoutStates {
  final String message;

  PostLogoutDataFailedState({required this.message});
}

class PostLogoutDataLoadingState extends LogoutStates {}


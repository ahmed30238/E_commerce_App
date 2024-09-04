abstract class ChangepasswordState {}

class ChangepasswordInitial extends ChangepasswordState {}

class ChangepasswordLoading extends ChangepasswordState {}

class ChangepasswordError extends ChangepasswordState {
  final String message;

  ChangepasswordError({required this.message});
}

class ChangepasswordSuccess extends ChangepasswordState {}

class ChangepasswordVisibiltyState extends ChangepasswordState {}

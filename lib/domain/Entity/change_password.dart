class ChangePasswordEntity {
  final bool status;
  final String message;
  final PasswordModificationData data;

  ChangePasswordEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class PasswordModificationData {
  final String email;

  PasswordModificationData({required this.email});
}

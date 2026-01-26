abstract class login_state {}

class LoginInitial extends login_state {}

class LoginLoading extends login_state {}

class LoginSuccess extends login_state {}

class LoginError extends login_state {
  final String message;
  LoginError(this.message);
}
class FingerprintStatusLoaded extends login_state {
  final bool isEnabled;
  final String? uid;

  FingerprintStatusLoaded({
    required this.isEnabled,
    required this.uid,
  });
}

class FingerprintNotLinked extends login_state {}

class FingerprintLinked extends login_state {
  final String uid;
  FingerprintLinked({required this.uid});
}





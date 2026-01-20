abstract class login_state {}

class LoginInitial extends login_state {}

class LoginLoading extends login_state {}

class LoginSuccess extends login_state {}

class LoginError extends login_state {
  final String message;
  LoginError(this.message);
}


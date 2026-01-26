abstract class SignInWithGoogleState {}

class GoogleAuthInitial extends SignInWithGoogleState {}

class GoogleAuthLoading extends SignInWithGoogleState {}

class GoogleAuthSuccess extends SignInWithGoogleState {}



class GoogleAuthError extends SignInWithGoogleState {
  final String message;
  GoogleAuthError(this.message);
}

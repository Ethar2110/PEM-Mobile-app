abstract class BiometricState {}

class BiometricInitial extends BiometricState {}

class BiometricAvailable extends BiometricState {}

class BiometricUnavailable extends BiometricState {
  final String reason;
  BiometricUnavailable(this.reason);
}

class BiometricAuthenticated extends BiometricState {
  final String uid;
  BiometricAuthenticated({required this.uid});
}

class BiometricFailed extends BiometricState {
  final String message;
  BiometricFailed(this.message);
}



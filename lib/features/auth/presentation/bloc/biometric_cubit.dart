import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit() : super(BiometricInitial());

  final LocalAuthentication _auth = LocalAuthentication();

  Future<void> checkAvailability() async {
    try {
      final bool canCheck = await _auth.canCheckBiometrics;
      final bool isSupported = await _auth.isDeviceSupported();

      if (!canCheck || !isSupported) {
        emit(BiometricUnavailable("Biometrics not supported"));
        return;
      }

      emit(BiometricAvailable());
    } catch (_) {
      emit(BiometricUnavailable("Biometric error"));
    }
  }

  Future<void> authenticate(String uid) async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Authenticate using fingerprint',
        biometricOnly: true,
      );

      if (didAuthenticate) {
        emit(BiometricAuthenticated(uid: uid));
      } else {
        emit(BiometricFailed("Authentication failed"));
      }
    } catch (_) {
      emit(BiometricFailed("Something went wrong"));
    }
  }


}

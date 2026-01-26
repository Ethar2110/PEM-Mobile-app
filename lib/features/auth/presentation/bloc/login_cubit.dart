import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Data/datasources/local_storage.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<login_state> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(LoginSuccess());

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await LocalStorage.saveEmailUid(email, user.uid);
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.message ?? 'Login failed'));
    } catch (e) {
      emit(LoginError('Something went wrong'));
    }
  }



  Future<void> checkFingerprintByEmail(String email) async {
    final uid = await LocalStorage.getUidByEmail(email);

    if (uid != null) {
      final isEnabled = await LocalStorage.isFingerprintEnabled(uid);
      emit(FingerprintStatusLoaded(isEnabled: isEnabled, uid: uid));
    } else {
      emit(FingerprintStatusLoaded(isEnabled: false, uid: null));
    }
  }


  Future<void> tryFingerprintLogin(String email) async {
    final uid = await LocalStorage.getUidByEmail(email);

    if (uid == null) {
      emit(FingerprintNotLinked());
      return;
    }

    final enabled = await LocalStorage.isFingerprintEnabled(uid);

    if (!enabled) {
      emit(FingerprintNotLinked());
      return;
    }

    emit(FingerprintLinked(uid: uid));
  }

}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.message ?? 'Login failed'));
    } catch (e) {
      emit(LoginError('Something went wrong'));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signUp_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignUpError(e.message ?? 'Sign up failed'));
    } catch (e) {
      emit(SignUpError('Something went wrong'));
    }
  }
}

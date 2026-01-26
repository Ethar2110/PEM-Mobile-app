import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'forgetpassword_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      emit(ForgetPasswordError("Enter your email"));
      return;
    }

    emit(ForgetPasswordLoading());

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.trim());

      emit(ForgetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ForgetPasswordError(e.message ?? "Firebase error"));
    }
  }
}

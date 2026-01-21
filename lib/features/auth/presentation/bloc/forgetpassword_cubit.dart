import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'forgetpassword_state.dart';


class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword(String email) async {
    emit(ForgetPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.trim(),
      );
      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(ForgetPasswordError(e.toString()));
    }
  }

}

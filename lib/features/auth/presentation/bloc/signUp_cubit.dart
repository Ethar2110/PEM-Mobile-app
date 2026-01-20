import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signUp_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    emit(SignUpLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
        'email': email,
        'username': username,
        'phone': phone,
      });

      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignUpError(e.message ?? 'Sign up failed'));
    } catch (e) {
      emit(SignUpError('Something went wrong'));
    }
  }
}

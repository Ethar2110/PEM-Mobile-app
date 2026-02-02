import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Data/datasources/local_storage.dart';
import 'fingerPringVal_cubit.dart';
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
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print("AUTH SUCCESS UID = ${userCredential.user!.uid}");

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': email,
          'username': username,
          'phone': phone,
        });



        print("FIRESTORE WRITE SUCCESS");
        emit(SignUpSuccess());

      } catch (firestoreError) {
        await userCredential.user?.delete();
        emit(SignUpError(
            'Failed to save user data: ${firestoreError.toString()}'));
      }

    } on FirebaseAuthException catch (e) {
      emit(SignUpError(e.message ?? 'Sign up failed'));
    } catch (e) {
      emit(SignUpError('Unexpected error: ${e.toString()}'));
    }
  }
}

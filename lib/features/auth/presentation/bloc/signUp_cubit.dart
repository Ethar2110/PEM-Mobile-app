import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      // 1️⃣ Create the user in Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print("AUTH SUCCESS UID = ${userCredential.user!.uid}");

      try {
        // 2️⃣ Save user info in Firestore
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
        // If Firestore fails, delete the auth user to avoid inconsistent state
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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'signInWithGoogle_state.dart';

class SignInWithGoogleCubit extends Cubit<SignInWithGoogleState> {
  SignInWithGoogleCubit() : super(GoogleAuthInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleAuthLoading());

    try {
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(GoogleAuthInitial());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      emit(GoogleAuthSuccess());
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }
}

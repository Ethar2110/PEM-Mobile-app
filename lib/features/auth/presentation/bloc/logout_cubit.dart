import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutCubit extends Cubit<void> {
  LogoutCubit() : super(null);

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    // await _googleSignIn.signOut();
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/datasources/local_storage.dart';
import 'fingerPrint_state.dart';

class FingerprintCubit extends Cubit<FingerprintState> {
  FingerprintCubit() : super(FingerprintState(uid: '', enabled: false));

  Future<void> loadFingerprintStatus(String uid) async {
    final enabled = await LocalStorage.isFingerprintEnabled(uid) ?? false;
    print("Loaded $enabled for $uid");
    emit(FingerprintState(uid: uid, enabled: enabled));
  }


  Future<void> setEnabled(String uid, bool value) async {
    if (uid.isEmpty) return;

    await LocalStorage.saveFingerprint(uid, value);
    print("Saved $value for $uid");
    emit(FingerprintState(uid: uid, enabled: value));
  }
}

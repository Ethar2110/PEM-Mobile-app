import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static String key(String uid) => "fingerprint_enabled_$uid";

  static Future<void> saveFingerprint(String uid, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key(uid), value);
  }

  static Future<bool> isFingerprintEnabled(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key(uid)) ?? false;
  }

  static Future<void> saveEmailUid(String email, String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid_for_$email", uid);
  }

  static Future<String?> getUidByEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("uid_for_$email");
  }

  static Future<void> saveLastUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("last_uid", uid);
  }

  static Future<String?> getLastUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("last_uid");
  }
}

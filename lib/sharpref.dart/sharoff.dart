import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static Future<bool> storeString(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(key, value);
  }

  static Future<String> getString(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? "";
  }

  static Future<bool> removed(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }
}

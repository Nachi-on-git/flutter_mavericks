import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  /// set value in storage using key
  void setKey({String? key, String? value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value != null) {
      await prefs.setString(key!, value);
    }
  }

  /// set user auth token
  void setUserToken({String? authToken}) {
    setKey(key: 'token', value: authToken);
  }

  /// get user auth token
  Future<String?> getUserToken({String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key!);
  }

  /// clear storage
  Future clearStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // void get value by key
  Future<String?> getValue({String? key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key!);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<void> saveData(String value, String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future<String> getdata(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString(key));
  }

  Future<void> clearData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }
}

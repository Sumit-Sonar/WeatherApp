import "package:shared_preferences/shared_preferences.dart";

class PreferencesClass {
  static const String lastCitySearchedKey = 'lastcitysearched';
  static Future<void> saveLastSearchedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(lastCitySearchedKey, city);
  }

  static Future<String?> getlastsearchedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastCitySearchedKey);
  }
}

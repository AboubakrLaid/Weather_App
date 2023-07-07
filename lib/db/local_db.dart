import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  LocalDB._();
  static final _instance = LocalDB._();

  factory LocalDB() => _instance;

  SharedPreferences? _prefs;

  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future clear() async {
    await _prefs?.clear();
  }

  Future<bool?> isDarkMode() async {
    await _init();
    return _prefs?.getBool('isDarkMode');
  }

  Future<void> setTheme(bool isDarkMode) async {
    await _init();
    await _prefs?.setBool('isDarkMode', isDarkMode);
  }

  Future<void> markOnBordingAsSeen() async {
    await _init();
    await _prefs?.setBool("hasSeenOnBording", true);
  }

  Future<bool?> hasSeenOnboarding() async {
    await _init();
    return _prefs?.getBool('hasSeenOnBording');
  }

  Future<void> setFavoriteLocation(String city) async {
    await _init();
    await _prefs?.setString("currentLocation", city);
  }

  Future<String?> getFavoriteLocation() async {
    await _init();
    return _prefs?.getString("currentLocation");
  }

  Future<void> setLocations(List<String> locations) async {
    await _init();
    await _prefs?.setStringList("locations", locations);
  }

  Future<List<String>?> getLocations() async {
    await _init();
    return _prefs?.getStringList("locations");
  }
}

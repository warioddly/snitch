import 'package:shared_preferences/shared_preferences.dart';
import 'package:snitch_inspector/shared/base/store.dart';

final class LocalStorage extends Store {
  LocalStorage._();

  static final instance = LocalStorage._();

  // SharedPreferences get prefs {
  //   assert(_prefs != null, 'LocalStorage not initialized. Call init() first.');
  //   return _prefs!;
  // }

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> set(String key, dynamic value) {
    return switch (value) {
      int _ => _prefs.setInt(key, value),
      double _ => _prefs.setDouble(key, value),
      String _ => _prefs.setString(key, value),
      bool _ => _prefs.setBool(key, value),
      List<String> _ => _prefs.setStringList(key, value),
      _ => throw UnsupportedError('Unsupported value type: $value'),
    };
  }

  @override
  T? get<T>(String key) {
    if (T is int) {
      return _prefs.getInt(key) as T?;
    } else if (T is double) {
      return _prefs.getDouble(key) as T?;
    } else if (T is String) {
      return _prefs.getString(key) as T?;
    } else if (T is bool) {
      return _prefs.getBool(key) as T?;
    } else if (T is List<String>) {
      return _prefs.getStringList(key) as T?;
    }

    return null;
  }

  @override
  Future<bool> remove(String key) => _prefs.remove(key);
}

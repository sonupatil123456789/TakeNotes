import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SeassionManager {
  Future<void> setAccessToken(String key, String object) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, object);
  }

  Future getAccessToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return jsonString;
    }
    return null;
  }

  static Future<void> saveObjectToSharedPreferences(
      String key, Map<String, dynamic> object) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringData = jsonEncode(object);
    await prefs.setString(key, jsonStringData);
  }

  static Future<Map<String, dynamic>?> getObjectFromSharedPreferences(
      String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static removeObjectFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    return true;
  }
}

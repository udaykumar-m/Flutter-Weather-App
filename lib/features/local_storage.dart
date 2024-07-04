// import 'package:shared_preferences/shared_preferences.dart';

// Future<List> getData() async{
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? language = prefs.getString('language');
//   final List<String>? topics = prefs.getStringList('topics');
//   print("get Data -- ");
//   print(language);
//   print(topics);
//   return [language, topics];
// }

// void setData(prefsAdd) async{
//   print(prefsAdd);
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('language', prefsAdd[0]);
//   prefsAdd.removeAt(0);
//   await prefs.setStringList('topics', prefsAdd);
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> initiate() async {
    if (_prefs == null) {
      WidgetsFlutterBinding.ensureInitialized();
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  static Future<void> setString({
    required String key,
    required String value,
  }) async {
    await _prefs?.setString(key, value);
    return;
  }

  // static Future<void> setInt({required String key, required int value}) async {
  //   await _prefs?.setInt(key, value);
  // }

  // static Future<void> setDouble({
  //   required String key,
  //   required double value,
  // }) async {
  //   await _prefs?.setDouble(key, value);
  // }

  // static Future<void> setBool({
  //   required String key,
  //   required bool value,
  // }) async {
  //   await _prefs?.setBool(key, value);
  // }

  static Future<void> setStringList({
    required String key,
    required List<String> value,
  }) async {
    await _prefs?.setStringList(key, value);
  }

  static String? getString(String key, {String? def = ''}) {
    return _prefs?.getString(key) ?? def;
  }

  // static int getInt(String key, {int def = 0}) {
  //   final val = _prefs?.getInt(key);
  //   return val ?? def;
  // }

  // static double getDouble(String key, {double def = 0.0}) {
  //   final val = _prefs?.getDouble(key);
  //   return val ?? def;
  // }

  // static bool getBool(String key, {bool def = false}) {
  //   final val = _prefs?.getBool(key);
  //   return val ?? def;
  // }

  static List<String> getStringList(String key, {List<String> def = const []}) {
    final val = _prefs?.getStringList(key);
    return val ?? def;
  }

  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  static bool exists(String key) {
    return _prefs!.containsKey(key);
  }

  static void clear() {
    _prefs?.clear();
  }

  static void reload() {
    _prefs?.reload();
  }
}

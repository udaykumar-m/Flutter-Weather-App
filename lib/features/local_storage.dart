import 'package:shared_preferences/shared_preferences.dart';



Future<List> getData() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? language = prefs.getString('language');
  final List<String>? topics = prefs.getStringList('topics');
  print("get Data -- ");
  print(language);
  print(topics);
  return [language, topics];
}

void setData(prefsAdd) async{
  print(prefsAdd);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('language', prefsAdd[0]);
  prefsAdd.removeAt(0);
  await prefs.setStringList('topics', prefsAdd);
}
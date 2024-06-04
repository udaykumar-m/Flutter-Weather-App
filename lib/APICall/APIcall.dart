import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openai_app/constants.dart';
import 'package:openai_app/model/api_model.dart';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

class ApiService {
  Future<List<Welcome>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print("API call");
        List<Welcome> _model = welcomeFromJson(response.body) ;
        
        print("API call completed");
        return _model;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
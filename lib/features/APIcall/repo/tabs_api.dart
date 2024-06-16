import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:openai_app/constants.dart';
import 'package:openai_app/features/APIcall/model/Open_ai_model.dart';

class TabsAPI {
  static GetTabsAPI() async {
    var client = http.Client();
    var content = '';
    try {
      final body = {
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": content}
        ],
        "max_tokens": 100,
        "temperature": 1,
      };
      final jsonString = json.encode(body);
      final uri = Uri.https(ApiConstants.baseUrl, ApiConstants.params);
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'Bearer sk-proj-eLP4CLqBsTsJlhK6aeGIT3BlbkFJkP2qmofKhH2FC0tUP2fO'
      };
      final response =
          await client.post(uri, headers: headers, body: jsonString);

      print('-------------');
      print(response.body.toString());

      OpenAiRes resp = openAiResFromJson(response.body.toString());

      return resp;
    } catch (e) {
      print(e.toString());
    }
  }
}

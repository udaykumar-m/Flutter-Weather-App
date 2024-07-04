import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:openai_app/constants.dart';
import 'package:openai_app/features/APIcall/model/Open_ai_model.dart';

import '../../local_storage.dart';

class QuotesRepo {
  static GetQuotesAPI() async {
    var client = http.Client();

    final _random = new Random();
    final topicsList = PreferenceHelper.getStringList('topics');
    final topic = topicsList[_random.nextInt(topicsList.length)];
    final query =
        "generate a one line unique $topic quote in ${PreferenceHelper.getString('language')}";
    print(query);

    try {
      final body = {
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content": query,
          },
        ],
        // "max_tokens": 100,
        "temperature": 1,
      };
      final jsonString = json.encode(body);
      final uri = Uri.https(ApiConstants.baseUrl, ApiConstants.params);
      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${dotenv.env['TOKEN'] ?? ''}"
      };
      final response =
          await client.post(uri, headers: headers, body: jsonString);

      OpenAiRes resp = openAiResFromJson(response.body.toString());

      return resp;
    } catch (e) {
      print(e.toString());
    }
  }
}

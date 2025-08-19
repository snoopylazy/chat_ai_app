import 'dart:convert';
import 'dart:io';
import 'package:chat_bot_app/data/remote/urls.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<dynamic> sendMsgApi({required String msg}) async {
    try {
      var response = await http.post(
        Uri.parse("${Urls.geminiBaseUrl}?key=${Urls.geminiApiKey}"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {"text": msg}
              ]
            }
          ]
        }),
      );
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['error'] != null) {
          throw (HttpException(data['error']['message']));
        }
        return data;
      }
    } catch (e) {
      throw(HttpException(e.toString()));
    }
  }
}

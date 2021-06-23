import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treaget/global.dart';

class AuthService {
  Future<Map> sendDataToLogin(Map body) async {
    var url = Uri.parse("$website/api/token/");
    final response = await http.post(url, body: body);

    var responseBody = json.decode(response.body);
    return responseBody;
  }

  static Future<bool> checkApiToken(String apiToken) async {
    var url = Uri.parse("$website/api/CheckToken/?token=$apiToken");
    final response =
        await http.get(url, headers: {'Accept': 'application/json'});

    return response.statusCode == 200;
  }
}

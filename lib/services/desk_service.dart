import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';


class DeskApi {
  static Future<Map> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/DeskApi/');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);
    if (response.statusCode == 200) {
      return {"result":responseBody};
    }
    else{
      return {"result":false};
    }

  }
}

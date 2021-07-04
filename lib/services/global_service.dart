import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';

class CurrentUserService {
  // ignore: missing_return
  static Future<Map> information() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user.api_token');
    String username = prefs.getString('user.username');
    var url = Uri.parse('$website/api/UserRetrieveApi/$username/');
    // var token = checkLogin();
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    // print(response.body);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      return {"result": responseBody};
    } else {
      return {"result": false};
    }
  }
}

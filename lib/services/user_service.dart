import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';
  import 'package:path/path.dart';
  import 'package:async/async.dart';

class UserApi {
  static Future<Map> randomUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/UserSearchListApi/?ordering=?&image=1');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);
    if (response.statusCode == 200) {
      return {"results":responseBody["results"]};
    }
    else{
      return {"results":false};
    }

  }

  static Future<Map> SearchUser({String text,int page:1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/UserSearchListApi/?search=$text&page=$page');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);
    if (response.statusCode == 200) {
      return {"results":responseBody["results"]};
    }
    else{
      return {"results":[]};
    }

  }
}

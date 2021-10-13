import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';
  import 'package:path/path.dart';
  import 'package:async/async.dart';

class TimelineApi {
  static Future<Map> addTimeline({var data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/timelineCreateApi/');
    String token = prefs.getString('user.api_token');
    var response = await http.post(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    },body: {  'body': data  });
    if (response.statusCode == 201) {
      return {"result":true};
    }
    else{
      return {"result":false};
    }

  }
}

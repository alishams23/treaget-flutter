import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/models/home_model.dart';
import 'package:treaget/global.dart';



class InformationProfileService {
  // ignore: missing_return

  static Future<Map> getInfo({String username = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selfUsername = prefs.getString('user.username');

    username == '' ? username = selfUsername : print("");
    var url = Uri.parse('$website/api/UserRetrieveApi/$username/');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);
      return responseBody;
    }
  }
}

class TimelineProfileService {
  static Future<Map> getResume({String username = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selfUsername = prefs.getString('user.username');
    username == '' ? username = selfUsername : print("");
    var url =
        Uri.parse('$website/api/timelineRetrieveApiView/?username=$username');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);
      return {"data": responseBody};
    }
    return {"data": "Null"};
  }
}

class ServiceProfileService {
  static Future<Map> getService({String username = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String selfUsername = prefs.getString('user.username');

    username == '' ? username = selfUsername : print("");
    var url = Uri.parse('$website/api/ServiceListApi/$username/');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);
      return {"data": responseBody};
    }
    return {"data": "Null"};
  }
}

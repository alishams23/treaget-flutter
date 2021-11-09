import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';

class SafePaymentService {
  static Future<Map> list() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/SafePaymentApi/');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    String source = Utf8Decoder().convert(response.bodyBytes);
    var responseBody = json.decode(source);
    if (response.statusCode == 200) {
      return {"result": responseBody};
    } else {
      return {"result": false};
    }
  }

  static Future<Map> accept({var pk}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/AcceptSafePaymentApi/?pk=$pk');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      return {"result": true};
    } else {
      return {"result": false};
    }
  }
   static Future<Map> refuse({var pk}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/RefuseSafePaymentApi/?pk=$pk');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      return {"result": true};
    } else {
      return {"result": false};
    }
  }
}

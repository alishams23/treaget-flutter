import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';

class OrdersService {
  // ignore: missing_return
  static Future<Map> getOrders(int page) async {
    var url = Uri.parse('$website/api/OrderApi/');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user.api_token');
    // var token = checkLogin();
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    // print(response.body);
    if (response.statusCode == 200) {
      var responseBody = json.decode(Utf8Decoder().convert(response.bodyBytes));
      return {"current_page": page, "results": responseBody["results"]};
    }
    return {"current_page": page, "results": null};
  }
}

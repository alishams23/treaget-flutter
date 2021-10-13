
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';


class RequestApi {
  static Future<Map> addRequest({var title,var price,var body = ""}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/AddRequestApi/');
    String token = prefs.getString('user.api_token');
    var response = await http.post(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    },body: {  'body': body ,'title':title , "price":price });
    if (response.statusCode == 201) {
      return {"result":true};
    }
    else{
      return {"result":false};
    }
  }
}

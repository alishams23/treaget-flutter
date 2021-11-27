import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';

class SpamApi {
  static Future<Map> addSpam(
      {var picture, var request, var user, var description}) async {
        
    Map body = picture != null
        ? {'picture': "$picture", "description": "$description"}
        : request != null
            ? {'request': "$request", "description": "$description"}
            : {"user": "$user", "description": "$description"};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/SpamCreateApi/');
    String token = prefs.getString('user.api_token');
    var response = await http.post(url,
        headers: {
          // 'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Token $token"
        },
        body: body);
    print(response.body);
    if (response.statusCode == 201) {
      return {"result": true};
    } else {
      return {"result": false};
    }
  }
}

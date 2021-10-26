import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';



class AuthService {
  Future<Map> sendDataToLogin(Map body) async {
    var url = Uri.parse("$website/api/token/");
    final response = await http.post(url, body: body);

    var responseBody = json.decode(response.body);
    print(response.statusCode);
    return {"data":responseBody,"statusCode":response.statusCode};
  }

  static Future<bool> checkApiToken(String apiToken) async {
    var url = Uri.parse("$website/api/CheckToken/?token=$apiToken");
    final response =
        await http.get(url, headers: {'Accept': 'application/json'});

    return response.statusCode == 200;
  }

  static Future<Map>  register({var username,var firstName,var lastName,var password,var serviceProvider,var email}) async {
    var url = Uri.parse('$website/api/UserCreate/');
    var response = await http.post(url, headers: {
       'Content-type': 'application/json',
      'Accept': 'application/json',
    },body:  json.encode({  'username': username ,'first_name':firstName , "last_name":lastName,"email":email,"ServiceProvider":serviceProvider,"password":password }));
    var responseBody = json.decode(response.body);
    return {"data":responseBody,"statusCode":response.statusCode};
  }

  static Future<Map> setting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/UserSettingApi/');
    String token = prefs.getString('user.api_token');
    var response = await http.put(url, headers: {
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

  static Future<Map> settingSendData({var firstName,var lastName,var bio}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/UserSettingApi/');
    String token = prefs.getString('user.api_token');
    var response = await http.put(url, headers: {
             'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    },body: json.encode({ 'first_name':firstName , "last_name":lastName,"bio":bio }));
    if (response.statusCode == 200) {
      return {"result":true};
    }
    else{
      return {"result":false};
    }

    

  }

  static Future<Map> addPictureProfile({var image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/UserSettingApi/');
    String token = prefs.getString('user.api_token');

    var length = await image.length();
    var request = http.MultipartRequest("PUT", url);
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));

    request.headers['Authorization'] = "Token $token";

    var picture = http.MultipartFile('image', stream, length,
        filename: basename(image.path));

    request.files.add(picture);

    var response = await request.send();
 
    if (response.statusCode == 200) {
      return {"result": true};
    } else {
      return {"result": false};
    }
  }
}

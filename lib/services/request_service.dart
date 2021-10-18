
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';
import 'package:treaget/models/home_model.dart';


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
  static Future<Map> acceptRequest({var day,var pk}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/AddAcceptRequestApi/$pk/');
    String token = prefs.getString('user.api_token');
    var response = await http.post(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    },body: {  'time': day });
    if (response.statusCode == 201) {
      return {"result":true};
    }
    else{
      return {"result":false};
    }
  }
  static Future<Map> remove({var id}) async {
    var url = Uri.parse('$website/api/DestroyRequestApi/$id/');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user.api_token');
    // var token = checkLogin();
    var response = await http.delete(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    print(response.body);

    if (response.statusCode == 204) {
      return {"result": true};
    } else {
      return {"result":false};
    }
   }

  static Future<Map> explore({var page=1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/ExploreProjectApiView/?page=$page');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    
    if (response.statusCode == 200) {
      
      String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);

      List<Post> post = [];
      responseBody["results"].forEach((item) {
       post.add(Post.fromJson({"item":"request","data":item}));
      });
     
      return {"current_page": page, "data": post};
    } if  (response.statusCode == 404)  {
      return {"current_page": page, "data": false};
    }
    
   }

    static Future<Map> getListRequest({String username = '', int page = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selfUsername = prefs.getString('user.username');
    username == '' ? username = selfUsername : print("");
    var url = Uri.parse('$website/api/RequestListApi/$username/');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);

      List<Post> post = [];
      responseBody.forEach((item) {
       post.add(Post.fromJson({"item":"request","data":item}));
      });
     
      return {"current_page": page, "data": post};
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/models/home_model.dart';
import 'package:treaget/global.dart';

class PostExploreService {
  // ignore: missing_return
  static Future<Map> getPosts(int page) async {
    var url = Uri.parse('$website/api/ExploreApiView/');
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
      String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);

      List<Post> post = [];
      responseBody.forEach((item) {
        post.add(Post.fromJson({"item":"picture","data":item}));
      });
      return {"current_page": page, "products": post};
    }
  }

  static Future<Map> search({int page,String text}) async {
    var url = Uri.parse('$website/api/PictureSearchApi/?page=$page&search=$text');
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
      String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);

      List<Post> post = [];
      responseBody["results"].forEach((item) {
        post.add(Post.fromJson({"item":"picture","data":item}));
      });
      return {"current_page": page, "products": post};
    }
  }
}

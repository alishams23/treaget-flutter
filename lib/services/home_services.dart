import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/models/home_model.dart';
import 'package:treaget/global.dart';

class PostService {
  // ignore: missing_return
  static Future<Map> getPosts(int page) async {
    var url = Uri.parse('$website/api/HomeApiView/?page=$page');
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
      var responseBody = json.decode(response.body);

      List<Post> post = [];
      responseBody.forEach((item) {
        post.add(Post.fromJson(item));
      });
      return {"current_page": page, "products": post};
    }
  }
}

class LikePost {
  static Future<bool> likePost(int pk) async {
    var url = Uri.parse('$website/api/AddLikeView/?Picture=$pk');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

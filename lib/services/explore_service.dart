import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/models/explore_model.dart';
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
      var responseBody = json.decode(response.body);

      List<Post> post = [];
      responseBody.forEach((item) {
        post.add(Post.fromJson(item));
      });
      return {"current_page": page, "products": post};
    }
  }
}

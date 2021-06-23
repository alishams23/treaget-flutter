import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treaget/models/home_model.dart';
import 'package:treaget/global.dart';

class PostService {
  static Future<Map> getPosts(int page) async {
    var url = Uri.parse('$website/api/HomeApiView/?page=$page');
    var token = checkLogin();
    final response =
        await http.get(url, headers: {"Authorization": "Token $token"});

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

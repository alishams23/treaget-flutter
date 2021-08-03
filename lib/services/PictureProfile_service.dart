import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/models/explore_model.dart';
import 'package:treaget/global.dart';

class PostPictureProfileService {
  // ignore: missing_return

  static Future<Map> getPosts({String username = '', int page = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selfUsername = prefs.getString('user.username');
    username == '' ? username = selfUsername : print("");
    var url = Uri.parse('$website/api/PicturePostListApi/$username/');
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
        post.add(Post.fromJson(item));
      });
      return {"current_page": page, "products": post};
    }
  }
}

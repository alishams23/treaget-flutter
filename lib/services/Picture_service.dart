import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:treaget/models/home_model.dart';

class PictureApi {
  static Future<Map> addPicture({var image, var alt}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/AddPostPictureApi/');
    String token = prefs.getString('user.api_token');

    var length = await image.length();

    var request = http.MultipartRequest("POST", url);
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    if (alt != null) request.fields['alt'] = alt;
    request.headers['Authorization'] = "Token $token";

    var picture = http.MultipartFile('image', stream, length,
        filename: basename(image.path));

    request.files.add(picture);

    var response = await request.send();

    if (response.statusCode == 201) {
      return {"result": true};
    } else {
      return {"result": false};
    }
  }

   static Future<Map> removePicture({var id}) async {
    var url = Uri.parse('$website/api/PicturePostDestroyRetrive/$id/');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user.api_token');
    // var token = checkLogin();
    var response = await http.delete(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    print(response.body);
    if (response.statusCode == 200) {
      return {"result": true};
    } else {
      return {"result":false};
    }
   }

   static Future<Map> getListPosts({String username = '', int page = 1}) async {
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
       post.add(Post.fromJson({"item":"picture","data":item}));
      });
      return {"current_page": page, "products": post};
    }
  }

  static Future<Map> getListFavorite({String username = '', int page = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selfUsername = prefs.getString('user.username');
    username == '' ? username = selfUsername : print("");
    var url = Uri.parse('$website/api/favoritesApi/$username/');
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
       post.add(Post.fromJson({"item":"picture","data":item}));
      });
      
      return {"current_page": page, "picture": post};
    }
  }
}

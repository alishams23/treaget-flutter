import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

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
}

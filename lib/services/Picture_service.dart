import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/models/home_model.dart';
import 'package:treaget/global.dart';
import 'package:dio/dio.dart';

class PictureApi {
  static Future<Map> addPicture({var image, var alt}) async {
    print("1111");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/AddPostPictureApi/');
    String token = prefs.getString('user.api_token');
    var dio = Dio();
    // var postBody = {
    //   'image': File(image.path).readAsBytesSync(),
    // };
      FormData formData = FormData.fromMap({
              "file":
                  await MultipartFile.fromFile(image.path),
          });
          dio.options.headers["authorization"] = "Token $token";
          // dio.options.headers['content-Type'] = 'application/json';

    dio.options.headers[HttpHeaders.authorizationHeader] ="Basic $token";
          var response = await dio.post('$website/api/AddPostPictureApi/', data: formData);
          print(response);
          // return response.data['id'];
    // final response = await http.post(
    //   url,
    //   headers: {
    //     // 'Content-type': 'application/json',
    //     "Content-Type":"multipart/form-data",
    //     // 'Accept':  "application/json; charset=utf-8",
    //     "Authorization": "Token $token"
    //   },
    //    encoding: Encoding.getByName("utf-8"),
    //   body: {
    //   'image': File(image.path).readAsBytesSync(),
    // },
    // );
    // var responseBody = json.decode(Utf8Decoder().convert(response.bodyBytes));

    // print(responseBody);

    // var response = await http.post(url, headers: {
    //   // 'Content-type': 'application/json',
    //   'Accept': 'application/json',
    //   "Authorization": "Token $token"
    // },body: {  'alt': alt , "image": image ,"author":2});
    // print("222222");
    // if (response.statusCode == 200) {
    //   return {"result":true};
    // }
    // else{
    //   return {"result":false};
    // }
  }
}

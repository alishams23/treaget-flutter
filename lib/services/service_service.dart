import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/models/home_model.dart';
import 'package:treaget/global.dart';

class AddServiceApi {

  static Future<Map> addService({String nameService = '', var priceService = 0}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/AddService/');
    String token = prefs.getString('user.api_token');
    var response = await http.post(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    },body: {  'price': priceService , "specialName": nameService });
    if (response.statusCode == 201) {
      return {"result":true};
    }
    else{
      return {"result":false};
    }
  }
static Future<Map> remove({var id}) async {
    var url = Uri.parse('$website/api/DestroyServiceApi/$id/');
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

}


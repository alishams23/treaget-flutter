import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:treaget/models/home_model.dart';

class MessageApi {


   static Future<Map> getListPersons() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
    var url = Uri.parse('$website/api/ListUserMessageApi/');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);
      return { "data": responseBody};
    }
  }
   static Future<Map> getMessage({username=""}) async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
    var url = Uri.parse('$website/api/AllMassageApi/?user=$username');
    String token = prefs.getString('user.api_token');
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    
    if (response.statusCode == 200) {
      String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);
      return { "data": responseBody};
    }
  }
static Future<Map> sendMessageData({var receiver,var text}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sender = prefs.getString('user.username');
    var url = Uri.parse('$website/api/MassageApi/');
    String token = prefs.getString('user.api_token');
    var response = await http.put(url, headers: {
             'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    },body: json.encode({ 'sender': sender, 'receiver': receiver ,'text': text }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return {"result":true};
    }
    else{
      return {"result":false};
    }
 
}}

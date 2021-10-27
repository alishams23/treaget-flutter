import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';

class OrdersService {
  // ignore: missing_return
  static Future<Map> getOrders(int page) async {
    var url = Uri.parse('$website/api/OrderApi/');
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
      var responseBody = json.decode(Utf8Decoder().convert(response.bodyBytes));
      print(responseBody);
      
      return {"current_page": page, "results": responseBody};
    }
    return {"current_page": page, "results": null};
  }

  static Future<bool> orderTrueApi(int pk) async {
    var url = Uri.parse('$website/api/OrderTrueApi/?pk=$pk');
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
      return true;
    }
    return false;
  }

  static Future<bool> orderFalseApi(int pk) async {
    var url = Uri.parse('$website/api/OrderFalseApi/?pk=$pk');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user.api_token');
    // var token = checkLogin();
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    });
    
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

   static Future<Map> add({String description = '', var data,var price = null }) async {
     List serviceOption=[];
    for (var item in data["serviceOption"]) {
      serviceOption.add("${item["id"]}");
      print(serviceOption);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/AddOrderApi/${data["author"]["username"]}/');
    String token = prefs.getString('user.api_token');

    var response = await http.post(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    },body: json.encode( {"optionsServiceMain": serviceOption, "price":price == null ? "${data["price"]}" : "$price", "title": data["specialName"] == null ? "${data["nameProduct"]["title"]}":"${data["specialName"]}", "body": "$description", "service": "${data["id"]}" }));

    if (response.statusCode == 201) {
      return {"result":true};
    }
    else{
      return {"result":false};
    }
  }

  
   static Future<Map> addNew({String description = '', var username,var price ,var title }) async {
   
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$website/api/AddOrderApi/$username/');
    String token = prefs.getString('user.api_token');

    var response = await http.post(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Token $token"
    },body: json.encode( { "price": "$price", "title": "$title", "body": "$description" }));

    if (response.statusCode == 201) {
      return {"result":true};
    }
    else{
      return {"result":false};
    }
  }
}

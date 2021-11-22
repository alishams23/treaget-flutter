import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';
  import 'package:path/path.dart';
  import 'package:async/async.dart';

class RulesApi {
  static Future<Map> listRules() async {
    var url = Uri.parse('$website/api/RulesListApi/');
    var response = await http.get(url, headers: {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    String source = Utf8Decoder().convert(response.bodyBytes);
      var responseBody = json.decode(source);
    if (response.statusCode == 200) {
      return {"results":responseBody};
    }
    else{
      return {"results":false};
    }

  }
}

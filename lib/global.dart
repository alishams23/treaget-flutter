import 'package:shared_preferences/shared_preferences.dart';

// var website = Uri.parse("https://treaget.com");
var website = Uri.parse("http://192.168.213.199:8000");

checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiToken = prefs.getString('user.api_token');
  return apiToken;
}

import 'package:shared_preferences/shared_preferences.dart';

var website = Uri.parse("http://172.16.213.12:8000");
checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiToken = prefs.getString('user.api_token');
  return apiToken;
}

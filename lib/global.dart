import 'package:shared_preferences/shared_preferences.dart';

var website = Uri.parse("https://treaget.com");
checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiToken = prefs.getString('user.api_token');
  return apiToken;
}

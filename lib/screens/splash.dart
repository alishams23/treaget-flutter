import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  navigationToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
  }

  navigationToHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 125,
                  height: 125,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ],
                      image: new DecorationImage(
                          image: new AssetImage("assets/images/logo.png"))),
                ),
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: new Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(
                  // minHeight: 2.0,
                  color: Colors.deepOrange,
                  backgroundColor: Colors.grey[100],
                ),
              ),
            )
          ],
        ));
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user.api_token');
    print(apiToken);
//    if(apiToken == null) navigationToLogin();
    // ignore: unrelated_type_equality_checks
    if (apiToken != null) {
      await Future.delayed(Duration(seconds: 2));
      navigationToHome();
    } else {
      if (await checkConnectionInternet()) {
        // check api Token
        // await AuthService.checkApiToken(apiToken)
        await Future.delayed(Duration(seconds: 2));
        navigationToLogin();
      } else {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            duration: new Duration(hours: 2),
            content: new GestureDetector(
              onTap: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
                checkLogin();
              },
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('از اتصال دستگاه به اینترنت مطمئن شوید',
                      style: TextStyle(fontFamily: 'Vazir')),
                  new Icon(Icons.wifi_lock, color: Colors.white)
                ],
              ),
            )));
      }
    }
  }

  Future<bool> checkConnectionInternet() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}

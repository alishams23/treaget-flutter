import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/animations/singin_animation.dart';
import 'package:treaget/components/Form.dart';
import 'package:treaget/services/auth_services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // AnimationController _loginButtonController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _emailValue;
  String _passwordValue;

  emailOnSaved(String value) {
    _emailValue = value;
  }

  passwordOnSaved(String value) {
    _passwordValue = value;
  }

  

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _loginButtonController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // timeDilation = .4;
    var page = MediaQuery.of(context).size;

    return new Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: new Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: new Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                new Opacity(
                  opacity: .1,
                  child: new Container(
                    width: page.width,
                    height: page.height,

                    // decoration: new BoxDecoration(
                    //     image: new DecorationImage(
                    //         image:
                    //             new AssetImage("assets/images/icon-background.png"),
                    //         repeat: ImageRepeat.repeat)),
                  ),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FormContainer(
                        formKey: _formKey,
                        emailOnSaved: emailOnSaved,
                        passwordOnSaved: passwordOnSaved),
                    new Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children:  [Text(
                          "آیا هیچ اکانتی ندارید؟ ",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.5,
                              color: Colors.black,
                              fontSize: 14),
                        ),GestureDetector(onTap: (){
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/register', (_) => false);
                        },child: Text(
                          "عضویت",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: Colors.blue,
                              fontSize: 14),
                        ),)]),Padding(padding: EdgeInsets.only(top: 20),child: GestureDetector(onTap: () async {
                                  const url = 'https://treaget.com/password_reset/';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw "cant lunch";
                                  }
                                },child: Text(
                          "فراموشی رمز عبور",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: Colors.blue,
                              fontSize: 14),
                        ),),)
                  ],
                ),
                new GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      sendDataForLogin();
                    }
                  },
                  child: Padding(padding: EdgeInsets.only(bottom: 20),child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.grey),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(0)),
                              ),
                              onPressed: () async{
                                if (_formKey.currentState.validate()) {
                                   _formKey.currentState.save();
                                  await sendDataForLogin();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 10),
                                child: Text(
                                  "ورود",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),)
                ),
              ],
            ),
          ),
        ));
  }

  sendDataForLogin() async {
    // await _loginButtonController.animateTo(0.150);
    Map response = await (new AuthService())
        .sendDataToLogin({"username": _emailValue, "password": _passwordValue});
    print(response);
    print(response['data']['token']);
    if (response['data']['token'] != null) {
      await storeUserData(response, _emailValue);
      // await _loginButtonController.forward();
   
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
   

    } else {
      // await _loginButtonController.reverse();
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text(
        "مشکلی در لاگین به وجود آمد لطفا نام کاربری و رمز عبور درستی را وارد کنید",
        style: new TextStyle(fontFamily: 'Vazir'),
      )));
    }
  }

  storeUserData(Map userData, username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.api_token', userData["data"]['token']);
    await prefs.setString('user.username', username);
  }
}

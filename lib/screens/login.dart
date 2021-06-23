import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/animations/singin_animation.dart';
import 'package:treaget/components/Form.dart';
import 'package:treaget/services/auth_services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _loginButtonController;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginButtonController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 3000));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    timeDilation = .4;
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
                    new FlatButton(
                        onPressed: null,
                        child: new Text(
                          "آیا هیچ اکانتی ندارید؟ عضویت",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.5,
                              color: Colors.black,
                              fontSize: 14),
                        ))
                  ],
                ),
                new GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      sendDataForLogin();
                    }
                  },
                  child: new SingInAnimation(
                    controller: _loginButtonController.view,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  sendDataForLogin() async {
    await _loginButtonController.animateTo(0.150);
    Map response = await (new AuthService())
        .sendDataToLogin({"username": _emailValue, "password": _passwordValue});
    print(response);
    print(response['token']);
    if (response['token'] != null) {
      await storeUserData(response);
      await _loginButtonController.forward();
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    } else {
      await _loginButtonController.reverse();
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
        "مشکلی در لاگین به وجود آمد",
        style: new TextStyle(fontFamily: 'Vazir'),
      )));
    }
  }

  storeUserData(Map userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.api_token', userData['token']);
    // await prefs.setInt('user.user_id', userData['user_id']);
  }
}

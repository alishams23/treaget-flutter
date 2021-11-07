import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/components/InputFields.dart';
import 'package:treaget/services/auth_services.dart';
import 'package:treaget/services/orders_service.dart';
import 'package:treaget/services/request_service.dart';
import 'package:validators/validators.dart';

class Register extends StatefulWidget {
  Register();
  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  var password;
  var firstName;
  var lastName;
  var emailName;
  var username;
  bool serviceProvider = true;
  var result;

  String validateForm(String value) {
    if (!value.isNotEmpty) {
      return "نباید این قسمت خالی باشد";
    }
    return null;
  }

sendDataForLogin() async {
    Map response = await  AuthService.register(username: username,password: password,serviceProvider:serviceProvider,firstName: firstName,lastName: lastName,email: emailName);
    print(response["data"]['token']);
    if (response["data"]['token'] != null) {
      await storeUserData(response, username);
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    } else {
     
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text(
        "مشکلی در ثبت نام به وجود آمد لطفا فیلد ها را به درستی وارد کنید",
        style: new TextStyle(fontFamily: 'Vazir'),
      )));
    }
  }
storeUserData(Map userData, username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.api_token', userData["data"]['token']);
    await prefs.setString('user.username', username);
  }
  @override
  Widget build(BuildContext context) {
    var page = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: new Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: new BoxDecoration(color: Colors.white),
            child: new Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: formKey,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                                onSaved: (var value) {setState(() {
                                  username = value;
                                });},
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                // style: const TextStyle(
                                //   color: Colors.white
                                // ),
                                decoration: new InputDecoration(
                                    icon: new Icon(
                                      Icons.person_outline,
                                      color: Colors.black,
                                    ),
                                    enabledBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: new BorderSide(
                                            color: Colors.grey[300])),
                                    focusedBorder: new OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: new BorderSide(
                                            color: Colors.black)),
                                    errorStyle:
                                        new TextStyle(color: Colors.red),
                                    errorBorder: new UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.red)),
                                    focusedErrorBorder:
                                        new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.red)),
                                    hintText: "نام کاربری",
                                    hintStyle: const TextStyle(fontSize: 15),
                                    contentPadding: const EdgeInsets.only(
                                        top: 15,
                                        right: 10,
                                        bottom: 20,
                                        left: 5)),
                                validator: (var value) {
                                  String pattern = r'^[0-9a-z]+$';
                                  RegExp regExp = new RegExp(pattern);
                                  if (!regExp.hasMatch(value)) {
                                    return 'نام کاربری وارد شده معتبر نیست';
                                  }
                                  return null;

                                }),
                          ),
                          new InputFieldArea(
                            hint: "پسورد",
                            obscure: true,
                            icon: Icons.lock_open,
                            onSaved: (var value){
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (String value) {
                              if (value.length < 9) {
                                return 'طول پسورد باید حداقل 8 کاراکتر باشد';
                              }
                            },
                          ),
                          new InputFieldArea(
                            hint: "ایمیل",
                            obscure: false,
                            icon: Icons.email_rounded,
                            onSaved: (var value){
                              setState(() {
                                emailName =value;
                              });
                            },
                            validator: (String value) {
                              if (!isEmail(value)) {
                                return 'ایمیل وارد شده معتبر نیست';
                              }
                            },
                          ),
                          new InputFieldArea(
                            hint: "نام",
                            obscure: false,
                            icon: Icons.person_outline,
                            onSaved: (var value){
                              setState(() {
                                firstName = value;
                              });
                            },
                            validator: (String value) {
                              if (value == null || value.isEmpty) {
                                return 'این فیلد اجباری است';
                              }
                            },
                          ),
                          new InputFieldArea(
                            hint: "نام خانوادگی",
                            obscure: false,
                            icon: Icons.person_outline,
                            onSaved: (var value){
                              lastName = value;
                            },
                            validator: (String value) {
                              if (value == null || value.isEmpty) {
                                return 'این فیلد اجباری است';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "خدمات دهنده (فریلنسر در زمینه طراحی،برنامه نویسی،ترجمه،دستیار مجازی و …)",
                            overflow: TextOverflow.visible,
                          )),
                          CupertinoSwitch(
                              value: serviceProvider,
                              onChanged: (var vale) {
                                setState(() {
                                  serviceProvider = !serviceProvider;
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "کارفرما (خدمات گیرنده و استخدام کننده)",
                            overflow: TextOverflow.visible,
                          )),
                          CupertinoSwitch(
                              value: !serviceProvider,
                              onChanged: (var vale) {
                                setState(() {
                                  serviceProvider = !serviceProvider;
                                });
                              })
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Text(
                              "کلیک روی ساخت اکانت به معنای موافقت با قوانین است",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "از قبل اکانتی دارید؟ ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/login', (_) => false);
                                    },
                                    child: Text(
                                      "ورود",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          color: Colors.blue,
                                          fontSize: 14),
                                    ),
                                  )
                                ]),
                            Padding(padding: EdgeInsets.only(top: 6)),
                            ElevatedButton(
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
                                if (formKey.currentState.validate()) {
                                   formKey.currentState.save();
                                  await sendDataForLogin();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 10),
                                child: Text(
                                  "ساخت اکانت",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )))
              ],
            ),
          ),
        ));
  }
}

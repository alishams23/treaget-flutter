import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/components/InputFields.dart';
import 'package:treaget/services/auth_services.dart';
import 'package:treaget/services/orders_service.dart';
import 'package:treaget/services/request_service.dart';
import 'package:validators/validators.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingState();
}

class SettingState extends State<Setting> {
  final formKey = GlobalKey<FormState>();
  var firstName;
  var lastName;
  var bio;
  var data;
  var result;

  String validateForm(String value) {
    if (!value.isNotEmpty) {
      return "نباید این قسمت خالی باشد";
    }
    return null;
  }

  getData() async {
    Map response = await AuthService.setting();
    setState(() {
      data = response["result"];
    });
    print(data);
  }

  sendDataForSetting() async {
    Map response = await AuthService.settingSendData(firstName: firstName,lastName: lastName,bio: bio);

    if (response["result"] != false) {
      Navigator.pushNamedAndRemoveUntil(context, "/profile", (_) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text(
        "مشکلی در ثبت نام به وجود آمد لطفا فیلد ها را به درستی وارد کنید",
        style: new TextStyle(fontFamily: 'Vazir'),
      )));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var page = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: new BoxDecoration(color: Colors.white),
        child: new Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            data != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Form(
                        key: formKey,
                        child: new Column(
                          children: <Widget>[
                            new InputFieldArea(
                              hint: "نام",
                              
                              initialValue: data['first_name'],
                              obscure: false,
                              icon: Icons.person_outline,
                              onSaved: (var value) {
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
                              initialValue: data['last_name'],
                              icon: Icons.person_outline,
                              onSaved: (var value) {
                                lastName = value;
                              },
                              validator: (String value) {
                                if (value == null || value.isEmpty) {
                                  return 'این فیلد اجباری است';
                                }
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: new TextFormField(
                                // validator: validator,
                               onSaved: (var value){
                              setState(() {
                                bio = value;
                              });
                            },
                                initialValue: "${data['bio']}",
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,
                                obscureText: false,

                                decoration: new InputDecoration(
                                    icon: new Icon(
                                      Icons.text_format,
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
                                    hintText: "بیو",
                                    hintStyle: const TextStyle(fontSize: 15),
                                    contentPadding: const EdgeInsets.only(
                                        top: 15,
                                        right: 10,
                                        bottom: 20,
                                        left: 5)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
            Positioned(
                bottom: 0,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 6)),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            shadowColor: MaterialStateProperty.all(Colors.grey),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(0)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              await sendDataForSetting();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                            child: Text(
                              "آپدیت کردن",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treaget/services/timeline_service.dart';

class AddResume extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddResumeState();
}

class AddResumeState extends State {
  final formKey = GlobalKey<FormState>();
  var data;
  var result;

String validateForm(String value) {
    if (! value.isNotEmpty) {
      return "نباید این قسمت خالی باشد";
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.9,
      ),
      body: Form(key: formKey,child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  // obscureText: true,
                  validator: validateForm,
                  textAlign: TextAlign.right,
                  onSaved: (var value) {
                    setState(() {
                      data = value;
                    });
                  },
                   
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],

                    labelText: 'توضیحات رزومه',
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey[300]),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    // hintTextDirection: TextDirection.rtl
                  ),
                )),
            Padding(padding: EdgeInsets.only(top: 20)),
            Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.0),
                    )),
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                  ),
                  onPressed: () async{
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      result = await TimelineApi.addTimeline(data: data);
                      if(result["result"])Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      "ذخیره کردن",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

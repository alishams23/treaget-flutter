import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treaget/services/request_service.dart';

class AddAcceptRequest extends StatefulWidget {
  var data;
  AddAcceptRequest(this.data);
  @override
  State<StatefulWidget> createState() => AddAcceptRequestState();
}

class AddAcceptRequestState extends State<AddAcceptRequest> {
  final formKey = GlobalKey<FormState>();
  var time;

  var result;

  String validateForm(String value) {
    if (!value.isNotEmpty) {
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
      body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                   
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          validator: validateForm,
                          textAlign: TextAlign.right,
                          onSaved: (var value) {
                            setState(() {
                              time = value;
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[50],
                            labelText: 'مدت زمان انجام کار',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.grey[300]),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                        ))
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        )),
                        shadowColor: MaterialStateProperty.all(Colors.grey),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          result = await RequestApi.acceptRequest(day: time,pk: widget.data.id);
                          if (result["result"])
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/home', (_) => false);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Text(
                          "ذخیره",
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treaget/services/request_service.dart';
import 'package:treaget/services/spam_service.dart';
import 'package:treaget/services/timeline_service.dart';

class AddSpam extends StatefulWidget {
  var picture;
  var request;
  var user;
  AddSpam({this.picture,this.request,this.user});
  @override
  State<StatefulWidget> createState() => AddSpamState();
}

class AddSpamState extends State<AddSpam> {
  final formKey = GlobalKey<FormState>();

  var description = "";
  var result;


  String validateForm(String value) {
    if (!value.isNotEmpty) {
      return "نباید این قسمت خالی باشد";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return   Form(
          key: formKey,
            child:Container(padding: EdgeInsets.symmetric(horizontal: 12),height: 180,child:  Column(
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
                              description = value;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'توضیحات ',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.grey[300]),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                        )),
                    
                  ],
                ),
               
                
                    ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                        shadowColor: MaterialStateProperty.all(Colors.grey),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange),
                        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          result = await SpamApi.addSpam( picture: widget.picture,request: widget.request,user: widget.user ,description:description);
                          if (result["result"] == true) Navigator.pop(context);
                        }
                       
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 70),
                        child: Text(
                          "ذخیره",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),)
              
         
    );
  }
}

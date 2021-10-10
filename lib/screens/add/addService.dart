import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treaget/components/loading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treaget/services/add_service.dart';

class AddService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddServiceState();
}

class AddServiceState extends State {
  var image;
  
  final formKey = GlobalKey<FormState>();
  var nameService ;
  var priceService ;
  var result;

  String validateService(String value) {
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
            Column(children: [Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  // obscureText: true,
                  textAlign: TextAlign.right,
                  onSaved: (var value){
                    nameService = value;
                  },
                  validator: validateService,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    labelText: 'نام خدمات',
                    
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey[300]),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    // hintTextDirection: TextDirection.rtl
                  ),
                )),Padding(padding: EdgeInsets.only(top: 20)),Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  // obscureText: true,
                   onSaved: (var value){
                    priceService = value;
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  validator: validateService,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    labelText: 'قیمت',
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey[300]),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    // hintTextDirection: TextDirection.rtl
                  ),
                )),],),
            

           Column(children: [
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
              onPressed: ()  {
                if(formKey.currentState.validate()){
                  formKey.currentState.save();
                  print(nameService);
                  result = AddServiceApi.addService(nameService:nameService,priceService:priceService );
                  print(result);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "پست کردن",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )],)
          ],
        ),
      )),
    );
  }
}

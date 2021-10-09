import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treaget/components/loading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';

class AddService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddServiceState();
}

class AddServiceState extends State {
  var image;
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.9,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  // obscureText: true,
                  textAlign: TextAlign.right,
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
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
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
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              ),
              onPressed: ()  {
                
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                  "انتخاب نام از دسته بندی",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),ElevatedButton(
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
      ),
    );
  }
}

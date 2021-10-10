import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/components/loading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treaget/services/Picture_service.dart';

class AddPicture extends StatefulWidget {
  var imageFile;

  AddPicture({Key key, this.imageFile}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AddPictureState();
}

class AddPictureState extends State<AddPicture> {
  final formKey = GlobalKey<FormState>();
  var alt;
  var result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.9,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            result = PictureApi.addPicture(image: widget.imageFile, alt: alt);
          }
        },
        label: Text("پست کردن"),
        icon: Icon(Icons.send_rounded),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget.imageFile != null
                      ? Container(
                          child: Image.file(
                          File(widget.imageFile.path),
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ))
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          // obscureText: true,
                          textAlign: TextAlign.right,
                          
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            labelText: 'توضیحات نمونه کار',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.grey[400]),
                              borderRadius: new BorderRadius.circular(0),
                            ),
                          ),
                        )),
                  ),

                  // Directionality(
                  //     textDirection: TextDirection.rtl,
                  //     child: TypeAheadField(
                  //       textFieldConfiguration: TextFieldConfiguration(
                  //         autofocus: true,
                  //         // style: DefaultTextStyle.of(context).style.copyWith(

                  //         // ),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: Colors.grey[100],

                  //           labelText: 'دسته بندی',
                  //           enabledBorder: UnderlineInputBorder(
                  //             borderSide: new BorderSide(color: Colors.grey),
                  //             borderRadius: new BorderRadius.circular(10),
                  //           ),

                  //         ),
                  //       ),
                  //       suggestionsCallback: (pattern) async {
                  //         // return await BackendService.getSuggestions(pattern);
                  //       },
                  //       itemBuilder: (context, suggestion) {
                  //         return ListTile(
                  //           leading: Icon(Icons.shopping_cart),
                  //           title: Text(suggestion['name']),
                  //           subtitle: Text('\$${suggestion['price']}'),
                  //         );
                  //       },
                  //       onSuggestionSelected: (suggestion) {
                  //         // Navigator.of(context).push(MaterialPageRoute(
                  //         //   builder: (context) => ProductPage(product: suggestion)
                  //         // ));
                  //       },
                  //     ))
                ],
              ),
            )),
      ),
    );
  }
}

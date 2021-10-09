import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treaget/components/loading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';

class AddPicture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddPictureState();
}

class AddPictureState extends State {
  var image;
  final ImagePicker _picker = ImagePicker();
  // bool _isLoading;
  // ScrollController _listScrollController = new ScrollController();
  // List orders = [];
  // int _currentPage = 1;

  // _getPost({int page: 1, bool refresh: false}) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   var response = await OrdersService.getOrders(page);
  //   setState(() {
  //     if (refresh) orders.clear();
  //     if (response['results'] != null) {
  //       orders.addAll(response['results']);
  //       _currentPage = page;
  //     }
  //     _isLoading = false;
  //   });
  // }

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
            Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  // obscureText: true,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    labelText: 'توضیحات نمونه کار',
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey[300]),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    // hintTextDirection: TextDirection.rtl
                  ),
                )),
            Padding(padding: EdgeInsets.only(top: 20)),
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

           Column(children: [ ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0),
                )),
                shadowColor: MaterialStateProperty.all(Colors.grey),
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              ),
              onPressed: () async {
                image = await _picker.pickImage(source: ImageSource.gallery);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "انتخاب عکس",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
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
                
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "پست کردن",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),],)
          ],
        ),
      ),
    );
  }
}

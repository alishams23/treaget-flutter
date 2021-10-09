import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  final Map data;
  Services({Key key, this.data}) : super(key: key);
  @override
  // ignore: non_constant_identifier_names
  State<StatefulWidget> createState() => StateServices();
}

class StateServices extends State<Services> {
  // List data;
  // StateServices({Key key, this.data}) : super(key: key);
  bool isExpandedState = false;
  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.grey.withOpacity(0.2),
      shadowColor: Colors.transparent,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(13)),
      textStyle: TextStyle(fontSize: 13, fontFamily: "Vazir"));
  @override
  void initState() {
    super.initState();
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            if (widget.data["price"] != null)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                  // width: double.infinity,
                  height: 70,
                  child: Text(
                    "تومان ${widget.data["price"]}",
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(0.0, -7.0),
                        blurRadius: 13.0,
                      ),
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        colors: [Color(0xffee4c0f), Color(0xffef726e)]),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 35),
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(0.0, -7.0),
                        blurRadius: 13.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(
                          widget.data["specialName"] != "" ?widget.data["specialName"] :widget.data["nameProduct"]["title"],
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      ExpansionPanelList(
                        elevation: 0,
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            isExpandedState = !isExpandedState;
                          });
                        },
                        children: [
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    style: style,
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.chat_outlined,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  ElevatedButton(
                                    style: style,
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 14,
                                          child: Icon(
                                            Icons.shopping_bag_outlined,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                          backgroundColor: Colors.grey[100],
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10)),
                                        Text(
                                          'سفارش',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            body: ListTile(
                              title: Text('Item 2 child'),
                              subtitle: Text('Details goes here'),
                            ),
                            isExpanded: isExpandedState,
                          ),
                        ],
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}

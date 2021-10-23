import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/screens/add/addOrderService.dart';
import 'package:treaget/services/service_service.dart';

class Services extends StatefulWidget {
  final Map data;
  var currentUser;
  var refreshPage;
  var arrayOption = [];

  Services(this.data, this.currentUser, this.refreshPage);
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

  additionPrice(value) {
    setState(() {
      widget.data["price"] != null
          ? widget.data["price"] += value
          : widget.data["price"] = value;
        
    });
  }

  subtractionPrice(value) {
    setState(() {
      widget.data["price"] != null
          ? widget.data["price"] -= value
          : widget.data["price"] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            if (widget.data["price"] != null || widget.data["price"] != "")
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
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
                        colors: [Color(0xffEA4C5F), Color(0xffE9511E)]),
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
                    gradient: LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white, Colors.grey[50]]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        offset: Offset(0.0, -4.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(
                          (widget.data["specialName"] != "" &&
                                  widget.data["specialName"] != null)
                              ? widget.data["specialName"]
                              : widget.data["nameProduct"]["title"] !=
                                      widget.data["specialName"]
                                  ? widget.data["nameProduct"]["title"]
                                  : "",
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
                            backgroundColor: Colors.transparent,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  widget.data["author"]["username"] !=
                                          widget.currentUser["username"]
                                      ? ElevatedButton(
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
                                        )
                                      : ElevatedButton(
                                          style: style,
                                          onPressed: () async {
                                            var result =
                                                await AddServiceApi.remove(
                                                    id: widget.data["id"]);
                                            if (result["result"] == true)
                                              widget.refreshPage();
                                          },
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 14,
                                                child: Icon(
                                                  LineIcons.trash,
                                                  color: Colors.black,
                                                  size: 18,
                                                ),
                                                backgroundColor:
                                                    Colors.grey[100],
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10)),
                                              Text(
                                                'حذف',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  widget.currentUser["ServiceProvider"] ==
                                              false &&
                                          widget.data["author"]["username"] !=
                                              widget.currentUser["username"]
                                      ? ElevatedButton(
                                          style: style,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        AddOrderService(
                                                            widget.data)));
                                          },
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 14,
                                                child: Icon(
                                                  Icons.shopping_bag_outlined,
                                                  color: Colors.black,
                                                  size: 18,
                                                ),
                                                backgroundColor:
                                                    Colors.grey[100],
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10)),
                                              Text(
                                                'سفارش',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                            },
                            body: widget.data["serviceOption"].length != 0
                                ? Container(
                                    // height: 150,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          widget.data["serviceOption"].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ServiceOption(
                                            widget.data["serviceOption"][index],
                                            additionPrice,
                                            subtractionPrice);
                                      },
                                    ),
                                  )
                                : Container(
                                    child: Text("آپشنی ثبت نشده"),
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

class ServiceOption extends StatefulWidget {
  var additionPrice;
  var data;
  var subtractionPrice;
  ServiceOption(this.data, this.additionPrice, this.subtractionPrice);
  @override
  State<StatefulWidget> createState() => ServiceOptionState();
}

class ServiceOptionState extends State<ServiceOption> {
  bool priceAdd = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.data["title"],
              style: TextStyle(fontSize: 18), overflow: TextOverflow.clip,

              // softWrap: false,
            ),
          )),
          widget.data["price"] != null
              ? Row(
                  children: [
                    Text("قیمت : ${widget.data["price"]}"),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: priceAdd == false
                            ? GestureDetector(
                                child: Icon(
                                  LineIcons.plusCircle,
                                  color: Colors.green,
                                ),
                                onTap: () {
                                  setState(() {
                                    widget.additionPrice(widget.data["price"]);
                                    priceAdd = true;
                                  });
                                },
                              )
                            : GestureDetector(
                                child: Icon(
                                  LineIcons.minusCircle,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  setState(() {
                                    widget
                                        .subtractionPrice(widget.data["price"]);
                                    priceAdd = false;
                                  });
                                },
                              ))
                  ],
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    LineIcons.checkCircle,
                    color: Colors.green,
                  ))
        ],
      ),
    );
  }
}

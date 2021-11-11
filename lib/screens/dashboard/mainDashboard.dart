import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/services/cash_service.dart';
import 'package:treaget/services/desk_service.dart';
import 'package:treaget/services/global_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global.dart';

Color darkBlue = Colors.deepOrange[600];
Color lightBlue = Colors.deepOrange[700];

class DashboardMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardMainState();
}

class DashboardMainState extends State<DashboardMain> {
  bool _isLoading = false;
  var cash = 0;
  var data;

  _getCountCash() async {
    setState(() {
      _isLoading = true;
    });
    var response = await CashApi.countCash();
    setState(() {
      if (response['result'] != false) {
        cash = response['result'];
      }
      _isLoading = false;
    });
  }

  _deskData() async {
    setState(() {
      _isLoading = true;
    });
    var response = await DeskApi.getData();
    setState(() {
      if (response['result'] != false) {
        data = response['result'];
      }
      _isLoading = false;
    });
  }

  void initState() {
    super.initState();
    _getCountCash();
    _deskData();
  }

  Widget cardDesk(var icon, Map data) {
    return Expanded(
        flex: 4,
        child: Container(
          height: 150,
          // width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(19.0),
                child: Container(
                    height: 48.0,
                    width: 48.0,
                    // color: Colors.grey[100],
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 19,
                        offset: Offset(0, 9),
                      )
                    ]),
                    child: Icon(
                      icon,
                      color: Colors.grey[800],
                    )),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                data["number"],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                data["text"],
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(19.0),
              border: Border.all(color: Colors.black.withOpacity(0.04)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                )
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: [Color(0xffEA4C5F), Color(0xffE9511E)]),

                  // color: darkBlue,
                  image: DecorationImage(
                    image: AssetImage("assets/images/pattern.png"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "کیف پول",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: Icon(
                                LineIcons.wallet,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  _getCountCash();
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.2),
                                  child: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 11.0,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "$cash",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .apply(color: Colors.white, fontWeightDelta: 2),
                          ),
                          TextSpan(text: "  تومان")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 11.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          side: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(.06)))),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.black.withOpacity(0.3)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.black.withOpacity(0.1)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(0)),
                                ),
                                onPressed: () async {
                                  const url = 'https://treaget.com/wallet/';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw "cant lunch";
                                  }
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    child: Text(
                                      "شارژ کیف پول",
                                      style: TextStyle(color: Colors.white),
                                    )))),
                        Flexible(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          side: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(.06)))),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.black.withOpacity(0.3)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.black.withOpacity(0.1)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(0)),
                                ),
                                onPressed: () async {
                                  const url = 'https://treaget.com/wallet/';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw "cant lunch";
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 20),
                                  child: Text(
                                    "دریافت وجه",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 15)),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              colors: [Colors.blue[900], Colors.blue[700]]),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        height: 21,
                        width: 3,
                      ),
                      Padding(padding: EdgeInsets.only(right: 9)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "نسخه اولیه تریگت در دسترس شما می باشد",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              data != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cardDesk(LineIcons.dollarSign, {
                          "text": "پرداخت امن",
                          "number": "${data['numberSafePayment']}"
                        }),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        cardDesk(LineIcons.shoppingBag, {
                          "text": "سفارشات",
                          "number": "${data['numberOrders']}"
                        }),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        cardDesk(LineIcons.handshake, {
                          "text": "درخواست",
                          "number": data['numberRequest'] == null
                              ? '0'
                              : "${data['numberRequest']}"
                        }),
                      ],
                    )
                  : Container()
            ],
          ),
        ));
  }
}

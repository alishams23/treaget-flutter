import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

Color darkBlue = Colors.deepOrange[600];
Color lightBlue = Colors.deepOrange[700];

class DashboardMain extends StatelessWidget {
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
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          child: Icon(
                            LineIcons.wallet,
                            color: Colors.white,
                          ),
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
                            text: "0000.00",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .apply(color: Colors.white, fontWeightDelta: 2),
                          ),
                          TextSpan(text: "تومان")
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
                                          )),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(0)),
                                ),
                                onPressed: () {},
                                child: Container(
                                    child: Container(
                                        child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(13.0),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 20),
                                        child: Text(
                                          "شارژ کیف پول",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black
                                                  .withOpacity(0.03)),
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          color: Colors.black.withOpacity(.1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))))),
                        Flexible(
                            child: ElevatedButton(
                                style: ButtonStyle(shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          )),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(0)),
                                ),
                                onPressed: () {},
                                child: Container(
                                    child: Container(
                                        child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(13.0),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        child: Text(
                                          "دریافت وجه",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black
                                                  .withOpacity(0.05)),
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          color: Colors.black.withOpacity(.1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))))),
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
                              colors: [Colors.blue[900], Colors.blue[500]]),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        height: 44,
                        width: 3,
                      ),
                      Padding(padding: EdgeInsets.only(right: 4)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ali shams عزیز خوش آمدید",
                            style: TextStyle(fontSize: 14),
                          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
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
                                    LineIcons.dollarSign,
                                    color: Colors.grey[800],
                                  )),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              "100",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "پرداخت امن",
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(19.0),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.04)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.13),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 9),
                              )
                            ]),
                      )),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Expanded(
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
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 19,
                                      offset: Offset(0, 9),
                                    )
                                  ]),
                                  child: Icon(
                                    LineIcons.shoppingBag,
                                    color: Colors.grey[800],
                                  )),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              "100",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "سفارشات",
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(19.0),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.04)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.13),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 9),
                              )
                            ]),
                      )),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Expanded(
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
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 19,
                                      offset: Offset(0, 9),
                                    )
                                  ]),
                                  child: Icon(
                                    LineIcons.handshake,
                                    color: Colors.grey[800],
                                  )),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              "100",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "درخواست",
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(19.0),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.04)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.13),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 9),
                              )
                            ]),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}

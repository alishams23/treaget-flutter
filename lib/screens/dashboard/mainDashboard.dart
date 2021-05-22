import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

// Color darkBlue = Color(0xff033e76);
// Color lightBlue = Color(0xff006bcf);
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
                      colors: [Color(0xffee4c0f), Color(0xffef726e)]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 1,
                      blurRadius: 19,
                      offset: Offset(0, 9),
                    )
                  ],
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
                    // Row(
                    //   children: <Widget>[
                    //     Icon(Icons.lock, color: Colors.grey[300]),
                    //     SizedBox(width: 5.0),
                    //     Text(
                    //       "Freezing amount: 1.0173 ETH",
                    //       style: TextStyle(color: Colors.grey[300]),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 11.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            color: Color(0xffff4600),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text(
                                  'شارژ کیف پول',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4)),
                                CircleAvatar(
                                  radius: 18,
                                  child: Icon(
                                    LineIcons.alternateSignIn,
                                    color: Colors.white,
                                  ),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.1),
                                )
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(9.0),
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: RaisedButton(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 15.0, vertical: 11.0),
                        //     color: darkBlue,
                        //     onPressed: () {},
                        //     child: Text(
                        //       'شارژ کیف پول',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: new BorderRadius.circular(9.0),
                        //         side: BorderSide(color: Colors.white)),
                        //   ),
                        // ),
                        Flexible(
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 11.0),
                            color: darkBlue,
                            onPressed: () {},
                            child: Text(
                              'دریافت وجه',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(9.0),
                                side: BorderSide(color: Colors.white)),
                          ),
                        ),
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 19,
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 19,
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 19,
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

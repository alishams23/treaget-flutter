import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/components/empty.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/screens/message/chat.dart';
import 'package:treaget/screens/profile.dart';
import 'package:treaget/services/safePayment_service.dart';

import '../global.dart';

class SafePayment extends StatefulWidget {
  Map data = {};
  Map currntUser = {};
  var handleRefresh;
  SafePayment({this.data, this.currntUser, this.handleRefresh});
  @override
  State<StatefulWidget> createState() => StateSafePayment();
}

class StateSafePayment extends State<SafePayment> {
  bool isLoadingAccept = false;
  bool isLoadingrefuse = false;
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    bool isSender = widget.currntUser["username"] == data["sender"]['username']
        ? true
        : false;
    var imageData = isSender
        ? data["receiver"]['image'] != null
            ? NetworkImage(data["receiver"]['image'])
            : AssetImage(("assets/images/avatar.png"))
        : data["sender"]['image'] != null
            ? NetworkImage(data["sender"]['image'])
            : AssetImage(("assets/images/avatar.png"));

    return Container(
      // height: 1,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.04)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.03),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3),
            )
          ]),
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Scaffold(
                                            body: Profile(
                                                username: isSender
                                                    ? data["receiver"]
                                                        ['username']
                                                    : data["sender"]
                                                        ['username']),
                                            backgroundColor: Colors.white,
                                          ))),
                              child: CircleAvatar(
                                backgroundImage: imageData,
                                backgroundColor: Colors.grey[300],
                                radius: 25,
                              ),
                            )),
                      )),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topRight,
                                    colors: [Colors.red, Colors.deepOrange]),
                              ),
                              height: 20,
                              width: 3,
                            ),
                            Padding(padding: EdgeInsets.only(right: 5)),
                            GestureDetector(
                              child: Text(
                                isSender
                                    ? data["receiver"]['username']
                                    : data["sender"]['username'],
                                style: TextStyle(fontSize: 15),
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Scaffold(
                                            body: Profile(
                                                username: isSender
                                                    ? data["receiver"]
                                                        ['username']
                                                    : data["sender"]
                                                        ['username']),
                                            backgroundColor: Colors.white,
                                          ))),
                            ),
                            Padding(padding: EdgeInsets.only(right: 5)),
                            Text(
                              "${data["createdAdd"]}",
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 12),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 10),
                          child: Text(
                            '${data["description"]}',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[800]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 10),
                          child: Text(
                            '${data["price"]} قیمت:',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                    flex: 8,
                  ),
                ],
              ),
              (isSender &&
                      data["paymentBoolean"] == true &&
                      data["senderBoolean"] == false)
                  ? Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200]),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("خدمات دهنده اتمام کار را فعال کرده",
                              style: TextStyle(fontSize: 14)),
                          Text(
                            " در صورتی که خدمات دهنده کار را به اتمام رسانده شما نیز باید اتمام کار را فعال کنید تا روند تکمیل شود ، در غیر این صورت باید در قسمت اعلام اختلاف مشکل مربوطه را مطرح کنید",
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                    )
                  : Container(),
              (isSender && data["paymentBoolean"] == null)
                  ? Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200]),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("خدمات دهنده لغو سفارش را انتخاب کرده است است",
                              style: TextStyle(fontSize: 14)),
                          Text(
                            "هزینه ای که از کیف پول شما کسر شده است به کف پول شما بازگشته است و میتوانید خرید دیگری انجام دهید",
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                    )
                  : Container(),
              (!isSender &&
                      data["senderBoolean"] == true &&
                      data["paymentBoolean"] == false)
                  ? Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200]),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("کارفرما اتمام کار را فعال کرده است است",
                              style: TextStyle(fontSize: 14)),
                          Text(
                            "شما نیز باید اتمام کار را بزنید تا روند تکمیل شود",
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                    )
                  : Container(),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey.withOpacity(0.2),
                              shadowColor: Colors.transparent,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(13)),
                              textStyle:
                                  TextStyle(fontSize: 13, fontFamily: "Vazir")),
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarUpdate);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                child: Icon(
                                  Icons.timeline,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                backgroundColor: Colors.grey[100],
                              ),
                              Padding(padding: EdgeInsets.only(right: 10)),
                              Text(
                                'مدیریت پروژه',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      !((data["paymentBoolean"] == true && !isSender) ||
                              (data["senderBoolean"] == true && isSender))
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shadowColor: Colors.transparent,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(13)),
                                    textStyle: TextStyle(
                                        fontSize: 13, fontFamily: "Vazir")),
                                onPressed: () async {
                                  if (isLoadingAccept == false) {
                                    setState(() {
                                      isLoadingAccept = true;
                                    });
                                    var result =
                                        await SafePaymentService.accept(
                                            pk: data["id"]);
                                    setState(() {
                                      isLoadingAccept = false;
                                    });
                                    if (result == true) widget.handleRefresh();
                                  }
                                },
                                child: isLoadingAccept
                                    ? SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: loadingViewCenterWhite(),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 14,
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            backgroundColor:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10)),
                                          Text(
                                            'اعلام اتمام کار',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                              ))
                          : Container(),
                      (!isSender &&
                              data["paymentBoolean"] != null &&
                              data["senderBoolean"] != true &&
                              data["paymentBoolean"] != true)
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shadowColor: Colors.transparent,
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(13)),
                                    textStyle: TextStyle(
                                        fontSize: 13, fontFamily: "Vazir")),
                                 onPressed: () async {
                                  if ( isLoadingrefuse == false) {
                                    setState(() {
                                      isLoadingrefuse = true;
                                    });
                                    var result =
                                        await SafePaymentService.refuse(
                                            pk: data["id"]);
                                    setState(() {
                                      isLoadingrefuse = false;
                                    });
                                    if (result == true) widget.handleRefresh();
                                  }
                                },
                                child: isLoadingAccept
                                    ? SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: loadingViewCenterWhite(),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 14,
                                            child: Icon(
                                              LineIcons.times,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            backgroundColor:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10)),
                                          Text(
                                            'لغو سفارش',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                              ))
                          : Container(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey.withOpacity(0.2),
                              shadowColor: Colors.transparent,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(13)),
                              textStyle:
                                  TextStyle(fontSize: 13, fontFamily: "Vazir")),
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (_) => Messages(
                                        user: isSender
                                            ? data["receiver"]
                                            : data["sender"],
                                      )),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                child: Icon(
                                  Icons.chat_bubble_outline,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                backgroundColor: Colors.grey[100],
                              ),
                              Padding(padding: EdgeInsets.only(right: 10)),
                              Text(
                                'چت کردن',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ), Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey.withOpacity(0.2),
                              shadowColor: Colors.transparent,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(13)),
                              textStyle:
                                  TextStyle(fontSize: 13, fontFamily: "Vazir")),
                          onPressed: () {ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarUpdate);},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                child: Icon(
                                  Icons.chat_bubble_outline,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                backgroundColor: Colors.grey[100],
                              ),
                              Padding(padding: EdgeInsets.only(right: 10)),
                              Text(
                                'اعلام اختلاف',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}

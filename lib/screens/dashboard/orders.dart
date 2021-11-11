import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/components/empty.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/screens/message/chat.dart';
import 'package:treaget/screens/profile.dart';
import 'package:treaget/services/orders_service.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/global.dart';
import 'package:url_launcher/url_launcher.dart';

class Orders extends StatefulWidget {
  Map info = {};
  Orders({this.info});
  @override
  State<StatefulWidget> createState() => StateOrders();
}

class StateOrders extends State<Orders> {
  bool _isLoading;
  ScrollController _listScrollController = new ScrollController();
  List orders = [];
  int _currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getOrder();
  }

  _getOrder({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await OrdersService.getOrders(page);
    setState(() {
      if (refresh) orders.clear();
      if (response['results'] != null) {
        orders.addAll(response['results']);
        _currentPage = page;
      }
      _isLoading = false;
    });
  }

  Future<Null> _handleRefresh() async {
    await _getOrder(refresh: true);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        orders != []
            ? RefreshIndicator(
                onRefresh: _handleRefresh,
                child: ListView.builder(
                    itemCount: orders.length,
                    controller: _listScrollController,
                    itemBuilder: (BuildContext context, int index) {
                      var data = orders[index];
                      bool isAuthor =
                          widget.info["username"] == data["author"]['username']
                              ? true
                              : false;
                      var imageData = isAuthor
                          ? data["designer"]['image'] != null
                              ? NetworkImage(data["designer"]['image'])
                              : AssetImage(("assets/images/avatar.png"))
                          : data["author"]['image'] != null
                              ? NetworkImage(data["author"]['image'])
                              : AssetImage(("assets/images/avatar.png"));
                      return Container(
                        // height: 1,
                        margin:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.04)),
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
                                                        builder: (context) =>
                                                            Scaffold(
                                                              body: Profile(
                                                                  username: isAuthor
                                                                      ? data["designer"]
                                                                          [
                                                                          'username']
                                                                      : data["author"]
                                                                          [
                                                                          'username']),
                                                              backgroundColor:
                                                                  Colors.white,
                                                            ))),
                                                child: CircleAvatar(
                                                  backgroundImage: imageData,
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  radius: 25,
                                                ),
                                              )),
                                        )),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10)),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gradient: LinearGradient(
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Colors.red,
                                                        Colors.deepOrange
                                                      ]),
                                                ),
                                                height: 20,
                                                width: 3,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5)),
                                              GestureDetector(
                                                child: Text(
                                                  isAuthor
                                                      ? data["designer"]
                                                          ['username']
                                                      : data["author"]
                                                          ['username'],
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                onTap: () => Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                        builder: (context) =>
                                                            Scaffold(
                                                              body: Profile(
                                                                  username: isAuthor
                                                                      ? data["designer"]
                                                                          [
                                                                          'username']
                                                                      : data["author"]
                                                                          [
                                                                          'username']),
                                                              backgroundColor:
                                                                  Colors.white,
                                                            ))),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5)),
                                              Text(
                                                "${data["createdAdd"]}",
                                                style: TextStyle(
                                                    color: Colors.grey[300],
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, right: 10),
                                            child: Text(
                                              (data["title"] != null &&
                                                      data["title"].isEmpty !=
                                                          true)
                                                  ? data["title"]
                                                  : (data["service"][
                                                                  "specialName"] !=
                                                              null &&
                                                          data["service"][
                                                                      "specialName"]
                                                                  .isEmpty !=
                                                              true)
                                                      ? data["service"]
                                                          ["specialName"]
                                                      : data["service"]
                                                              ["nameProduct"]
                                                          ["title"],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[800]),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, right: 10),
                                            child: Text(
                                              data["body"] != null
                                                  ? '${data["body"]}'
                                                  : '',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      flex: 8,
                                    ),
                                  ],
                                ),
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        (data["accept"] == true &&
                                                data["safePayment"] != null)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.grey
                                                          .withOpacity(0.2),
                                                      shadowColor:
                                                          Colors.transparent,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  13)),
                                                      textStyle: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: "Vazir")),
                                                  onPressed: () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            snackBarUpdate);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 14,
                                                        child: Icon(
                                                          Icons.timeline,
                                                          color: Colors.black,
                                                          size: 18,
                                                        ),
                                                        backgroundColor:
                                                            Colors.grey[100],
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10)),
                                                      Text(
                                                        'مدیریت پروژه',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        (data["accept"] == true &&
                                                (data["safePayment"] == false ||
                                                    data["safePayment"] ==
                                                        null))
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.green,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  13)),
                                                      textStyle: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: "Vazir")),
                                                  onPressed: () async {
                                                    var url =
                                                        'https://treaget.com/account/addSafePaymentOrder/${data["id"]}/';
                                                    if (await canLaunch(url)) {
                                                      await launch(url);
                                                    } else {
                                                      throw "cant lunch";
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 14,
                                                        child: Icon(
                                                          Icons
                                                              .payments_rounded,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.3),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10)),
                                                      Text(
                                                        'پرداخت امن',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            : Container(),
                                        (data["accept"] == null &&
                                                widget.info["username"] !=
                                                    data["author"]["username"])
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.green,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  13)),
                                                      textStyle: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: "Vazir")),
                                                  onPressed: () async {
                                                    var resultOrder =
                                                        await OrdersService
                                                            .orderTrueApi(
                                                                data["id"]);
                                                    if (resultOrder == true)
                                                      _handleRefresh();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 14,
                                                        child: Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.3),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10)),
                                                      Text(
                                                        'تایید سفارش',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            : Container(),
                                        data["accept"] == null
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.red,
                                                      shadowColor:
                                                          Colors.transparent,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  13)),
                                                      textStyle: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: "Vazir")),
                                                  onPressed: () async {
                                                    var resultOrder =
                                                        await OrdersService
                                                            .orderFalseApi(
                                                                data["id"]);
                                                    if (resultOrder == true)
                                                      _handleRefresh();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 14,
                                                        child: Icon(
                                                          LineIcons.times,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                        backgroundColor: Colors
                                                            .black
                                                            .withOpacity(0.3),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10)),
                                                      Text(
                                                        'لغو سفارش',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            : Container(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.grey
                                                    .withOpacity(0.2),
                                                shadowColor: Colors.transparent,
                                                shape:
                                                    new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(13)),
                                                textStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: "Vazir")),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                    builder: (_) => Messages(
                                                          user: isAuthor
                                                              ? data["author"]
                                                              : data[
                                                                  "designer"],
                                                        )),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 14,
                                                  child: Icon(
                                                    Icons.chat_bubble_outline,
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
                                                  'چت کردن',
                                                  style: TextStyle(
                                                      color: Colors.black),
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
                    }),
              )
            : loadingView(),
        _isLoading == true ? loadingView() : Container(),
        orders.length == 0 ? listIsEmpty() : Container(),
      ],
    );
  }
}

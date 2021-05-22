import 'package:flutter/material.dart';

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                // height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 19,
                      offset: Offset(0, 9),
                    )
                  ],
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(23.0),
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 19,
                                        offset: Offset(0, 9),
                                      )
                                    ]),
                                    child: Image.network(
                                      "https://treaget.com/media/profile/2021/01/03/66708141_2379602192358271_7304296654685244567_n.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                        )),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              children: [
                                Container(
                                  color: Colors.deepOrange[800],
                                  height: 44,
                                  width: 2,
                                ),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                Column(
                                  children: [
                                    Text(
                                      "alishams23",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "ali shams",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, right: 10),
                              child: Text(
                                "شما را دنبال می کند",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                // height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 19,
                      offset: Offset(0, 9),
                    )
                  ],
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            // height: 10.0,
                            // width: 10.0,
                            // color: Colors.black,

                            child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(23.0), //or 15.0
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 19,
                                        offset: Offset(0, 9),
                                      )
                                    ]),
                                    child: Image.network(
                                      "https://treaget.com/media/profile/2021/01/03/66708141_2379602192358271_7304296654685244567_n.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                        )),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              children: [
                                Container(
                                  color: Colors.deepOrange[800],
                                  height: 44,
                                  width: 2,
                                ),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                Column(
                                  children: [
                                    Text(
                                      "alishams23",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "ali shams",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, right: 10),
                              child: Text(
                                "شما را دنبال می کند",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                // height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 19,
                      offset: Offset(0, 9),
                    )
                  ],
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            // height: 10.0,
                            // width: 10.0,
                            // color: Colors.black,

                            child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(23.0), //or 15.0
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 19,
                                        offset: Offset(0, 9),
                                      )
                                    ]),
                                    child: Image.network(
                                      "https://treaget.com/media/profile/2021/01/03/66708141_2379602192358271_7304296654685244567_n.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                        )),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              children: [
                                Container(
                                  color: Colors.deepOrange[800],
                                  height: 44,
                                  width: 2,
                                ),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                Column(
                                  children: [
                                    Text(
                                      "alishams23",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "ali shams",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, right: 10),
                              child: Text(
                                "شما را دنبال می کند",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

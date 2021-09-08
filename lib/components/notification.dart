import 'package:flutter/material.dart';

class NotificationComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 1,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.02)),
        boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.13),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 9),
                              )
                            ]
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 25,
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
                      Text(
                        "ali shams",
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(padding: EdgeInsets.only(right: 5)),
                      Text(
                        "alishams23",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, right: 10),
                    child: Text(
                      "شما را دنبال می کند",
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
              flex: 8,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treaget/components/popupMenu/postRequestPopup.dart';
import 'package:treaget/screens/profile.dart';

class RequestCardComponent extends StatelessWidget {
  var data;
  var userInfo;
  RequestCardComponent(this.data, this.userInfo);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 15.0),
      padding: EdgeInsets.fromLTRB(15.0, 8.0, 19.0, 8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23.0),
          border: Border.all(color: Colors.grey[200]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Scaffold(
                                  body: Profile(
                                      username: data.author['username']),
                                  backgroundColor: Colors.white,
                                ))),
                    child: CircleAvatar(
                      radius: 21,
                      backgroundColor: Colors.grey[300],
                      child: ClipOval(
                        child: data.author["image"] != null
                            ? Image(
                                image: NetworkImage("${data.author['image']}"),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Scaffold(
                                  body: Profile(
                                      username: data.author['username']),
                                  backgroundColor: Colors.white,
                                ))),
                    child: Column(
                      children: [
                        Text(
                          data.author["username"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "قیمت : ${data.price}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              userInfo != null
                  ? PopupMenuButtonPostRequest(data, userInfo)
                  : Container()
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              data.title,
              style: TextStyle(fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
          ),
          Text(data.body),
          Padding(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin:EdgeInsets.only(right: 13),
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 13),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[200])
                      ),
                  child: Text("  پیشنهاد ${data.subcategories.length}",),
                ),
                (userInfo != null &&
                        userInfo["username"] != data.author["username"] &&
                        userInfo["ServiceProvider"] == true)
                    ? ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          )),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[200]),
                          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Scaffold(
                                      body: Profile(
                                          username: data.author['username']),
                                      backgroundColor: Colors.white,
                                    ))),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 33),
                          child: Text(
                            "قبول درخواست",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 10),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

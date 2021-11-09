import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treaget/components/popupMenu/postRequestPopup.dart';
import 'package:treaget/screens/add/acceptRequest.dart';
import 'package:treaget/screens/profile.dart';

class RequestCardComponent extends StatefulWidget {
  var data;
  var userInfo;
bool isHome ;
  RequestCardComponent(this.data, this.userInfo,this.isHome);

  @override
  State<StatefulWidget> createState() => RequestCardComponentState();
}

class RequestCardComponentState extends State<RequestCardComponent> {
  bool isExpandedState = false;
  var username;
  var n;
  bool checkAcceptRequestBool() {
    for (n in widget.data.subcategories) {
      if (n["author"]["username"] == widget.userInfo["username"]) {
        return false;
      }
    }
    return true;
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.grey.withOpacity(0.2),
      shadowColor: Colors.transparent,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(13)),
      textStyle: TextStyle(fontSize: 13, fontFamily: "Vazir"));
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 15.0),
      padding: EdgeInsets.fromLTRB(15.0, 8.0, 19.0, 8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23.0),
          border: Border.all(color:widget.isHome ? Colors.grey[50]:Colors.grey[200]),
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
                                      username: widget.data.author['username']),
                                  backgroundColor: Colors.white,
                                ))),
                    child: CircleAvatar(
                      radius: 21,
                      backgroundColor: Colors.grey[300],
                      child: ClipOval(
                        child: widget.data.author["image"] != null
                            ? Image(
                                image: NetworkImage(
                                    "${widget.data.author['image']}"),
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
                                      username: widget.data.author['username']),
                                  backgroundColor: Colors.white,
                                ))),
                    child: Column(
                      children: [
                        Text(
                          widget.data.author["username"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "قیمت : ${widget.data.price}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              widget.userInfo != null
                  ? PopupMenuButtonPostRequest(widget.data, widget.userInfo)
                  : Container()
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              widget.data.title,
              style: TextStyle(fontSize: 16),
              textDirection: TextDirection.rtl,
            ),
          ),
          Text(widget.data.body,style: TextStyle(fontSize: 14),),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          ExpansionPanelList(
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                isExpandedState = !isExpandedState;
              });
            },
            children: [
              ExpansionPanel(
              
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 13),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey[200])),
                        child: Text(
                          "  پیشنهاد ${widget.data.subcategories.length}",style: TextStyle(fontSize: 12),
                        ),
                      ),
                      (widget.userInfo != null &&
                              widget.userInfo["username"] !=
                                  widget.data.author["username"] &&
                              widget.userInfo["ServiceProvider"] == true &&
                              checkAcceptRequestBool() == true)
                          ? ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                )),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.grey[50]),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey[100]),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(0)),
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        AddAcceptRequest(widget.data),
                                  )),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "قبول درخواست  ",
                                  style: TextStyle(color: Colors.black,fontSize: 11),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(bottom: 10),
                            )
                    ],
                  );
                },
                body: widget.data.subcategories.length != 0
                    ? Container(
                        height: 300,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.data.subcategories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                  '${widget.data.subcategories[index]["time"]}'),
                              subtitle: Text(
                                  '${widget.data.subcategories[index]["author"]["username"]}'),
                              leading: CircleAvatar(
                                radius: 21,
                                backgroundColor: Colors.grey[300],
                                child: ClipOval(
                                  child: widget.data.subcategories[index]
                                              ["author"]["image"] !=
                                          null
                                      ? Image.network(
                                          "${widget.data.subcategories[index]["author"]['image']}",
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        child: Text("پیشنهادی ثبت نشده"),
                      ),
                isExpanded: isExpandedState,
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treaget/components/empty.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/services/message_service.dart';

import '../global.dart';
import 'message/chat.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

bool isLoading = false;

class _ChatPageState extends State<ChatPage> {
  List persons = [];
  Timer clockTimer;

  getPersons({int page: 1, bool refresh: false}) async {
    setState(() {
      if (refresh == false) isLoading = true;
    });
    var response = await MessageApi.getListPersons();
    setState(() {
      persons.clear();
      persons.addAll(response["data"]);
      isLoading = false;
    });
  }

  @override
  void dispose() {
    clockTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersons();
    clockTimer = Timer.periodic(new Duration(seconds: 3), (timer) {
      getPersons(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "chat",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30),
                    //     color: Colors.pink[50],
                    //   ),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Icon(
                    //         Icons.add,
                    //         color: Colors.pink,
                    //         size: 20,
                    //       ),
                    //       SizedBox(
                    //         width: 2,
                    //       ),
                    //       Text(
                    //         "Add New",
                    //         style: TextStyle(
                    //             fontSize: 14, fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextFormField(
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (var value) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBarUpdate);
                },
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            isLoading == true
                ? Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: loadingViewCenter(),
                  )
                : persons.length == 0
                    ? listIsEmpty()
                    : Container(),
            ListView.builder(
              itemCount: persons.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: persons[index]['user']['get_full_name'],
                  messageText: persons[index]['user']['bio'],
                  imageUrl: persons[index]['user']['image'],
                  time: "",
                  user: persons[index]['user'],
                  isMessageRead: persons[index]['number'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  int isMessageRead;
  Map user;
  ConversationList(
      {this.name,
      this.messageText,
      this.imageUrl,
      this.time,
      this.user,
      this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => Messages(
                      user: widget.user,
                    )));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: widget.imageUrl != null
                        ? NetworkImage(widget.imageUrl)
                        : AssetImage(("assets/images/avatar.png")),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${widget.name}",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText == null
                                ? "..."
                                : widget.messageText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead != 0
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.isMessageRead != 0
                ? CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 15,
                    child: Text(
                      "${widget.isMessageRead}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/components/popupMenu/postPicturePopup.dart';
import 'package:treaget/global.dart';

import 'package:treaget/models/home_model.dart';
import 'package:treaget/screens/profile.dart';
import 'package:treaget/services/home_services.dart';

class PostPicture extends StatefulWidget {
  Post data;
  var info;
  // ignore: avoid_init_to_null
  PostPicture({Key key, this.data: null, this.info: null}) : super(key: key);
  @override
  State<StatefulWidget> createState() => StatePostPicture();
}

class StatePostPicture extends State<PostPicture> {
  final snackBar = SnackBar(content: Text('متاسفانه این پست لایک نشد'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // AppBar(),
              GestureDetector(
                onDoubleTap: () async {
                  var likeTest = await LikePost.likePost(widget.data.id);

                  likeTest == true
                      ? setState(() {
                          widget.data.likePost();
                        })
                      : ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      ClipRRect(
                        // borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                            imageUrl: "${widget.data.image}",
                            fit: BoxFit.fitHeight,
                            placeholder: (context, url) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[400],
                                highlightColor: Colors.white,
                                enabled: true,
                                child: Container(
                                  height: 200,
                                  color: Colors.grey.withOpacity(0.2),
                                  // width: 100,
                                ),
                              );
                            }),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                            padding: EdgeInsets.only(bottom: 10, right: 10),
                            alignment: Alignment.topRight,
                            width: 120,
                            height: 60,
                            child: Container(
                                child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(19.0),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    width: 100,
                                    padding: EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            widget.data.like == true
                                                ? LineIcons.heartAlt
                                                : LineIcons.heart,
                                            color: widget.data.like == true
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                          iconSize: 24.0,
                                          onPressed: () async {
                                            var likeTest =
                                                await LikePost.likePost(
                                                    widget.data.id);
                                            // ignore: unrelated_type_equality_checks
                                            likeTest == true
                                                ? setState(() {
                                                    widget.data.likePost();
                                                  })
                                                : ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(LineIcons.bookmark),
                                          iconSize: 27.0,
                                          onPressed: () =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBarUpdate),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(19.0),
                                      color: Colors.white.withOpacity(.4),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
                      ),
                       widget.info != null?Container(
                          padding: EdgeInsets.only(top: 80, left: 10),
                          alignment: Alignment.topLeft,
                          width: 100,
                          height: 200,
                          child:  Container(
                              child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  padding: EdgeInsets.all(9),
                                  child: widget.info != null
                                      ? PopupMenuButtonPostPicture(
                                          widget.data, widget.info)
                                      : Text(""),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(18.0),
                                    color: Colors.white.withOpacity(.4),
                                  ),
                                ),
                              ),
                            ),
                          ))):Container(),
                      Container(
                          padding: EdgeInsets.only(top: 30, left: 10),
                          alignment: Alignment.topLeft,
                          width: 100,
                          height: 100,
                          child: Container(
                              child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(9),
                                    child: Icon(Icons.chevron_left),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white.withOpacity(0.1)),
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Colors.white.withOpacity(.4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )))
                    ],
                  ),
                ),
              ),
              widget.data.alt != null
                  ? Container(
                      padding: EdgeInsets.only(top: 20, right: 20, bottom: 20),
                      child: Text(
                        widget.data.alt,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  : Text(""),
              widget.data.category.length != 0
                  ? Container(
                      height: 60,
                      // padding: EdgeInsets.only(ri: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.data.category.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 16),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                 side: BorderSide(
                                  width: 1,
                                  color: Colors.grey[300],
                                ),
                                primary: Colors.white,
                                shadowColor: Colors.transparent,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(13)),
                                  textStyle: TextStyle(
                                      fontSize: 12, fontFamily: "Vazir")),
                              onPressed: () {},
                              child: Text(
                                "${widget.data.category[index]["title"]}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
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
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Scaffold(
                                          body: Profile(
                                              username: widget
                                                  .data.author['username']),
                                          backgroundColor: Colors.white,
                                        )))),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                        ),
                        Column(
                          children: [
                            Text(
                              widget.data.author["username"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              widget.data.createdAdd,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                      child: Row(
                        children: [
                          widget.data.likeUser.length >= 3
                              ? Stack(
                                  children: [
                                    Positioned(
                                        right: 7,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              widget.data.likeUser.length >= 3
                                                  ? widget.data.likeUser[2]
                                                              ["image"] !=
                                                          null
                                                      ? NetworkImage(widget.data
                                                          .likeUser[2]["image"])
                                                      : null
                                                  : null,
                                          radius: 14,
                                          backgroundColor: Colors.grey[200],
                                        )),
                                    Positioned(
                                        right: 21,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              widget.data.likeUser.length >= 2
                                                  ? widget.data.likeUser[1]
                                                              ["image"] !=
                                                          null
                                                      ? NetworkImage(widget.data
                                                          .likeUser[1]["image"])
                                                      : null
                                                  : null,
                                          radius: 14,
                                          backgroundColor: Colors.orange[200],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 32)),
                                    Positioned(
                                        child: CircleAvatar(
                                      backgroundImage:
                                          widget.data.likeUser.length >= 1
                                              ? widget.data.likeUser[0]
                                                          ["image"] !=
                                                      null
                                                  ? NetworkImage(widget.data
                                                      .likeUser[0]["image"])
                                                  : null
                                              : null,
                                      radius: 14,
                                      backgroundColor: Colors.deepOrange[400],
                                    ))
                                  ],
                                )
                              : Container(),
                          Padding(padding: EdgeInsets.only(right: 1)),
                          CircleAvatar(
                            child: Text(
                              "${widget.data.likeUser.length}",
                              style: TextStyle(fontSize: 13),
                            ),
                            radius: 14,
                            backgroundColor: Colors.orange[50],
                            foregroundColor: Colors.deepOrange,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treaget/components/empty.dart';
import 'package:treaget/components/explore/samplesExplore.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/components/popupMenu/postPicturePopup.dart';
import 'package:treaget/global.dart';

import 'package:treaget/models/home_model.dart';
import 'package:treaget/screens/profile.dart';
import 'package:treaget/services/explore_service.dart';
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
  List _products = [];
  int _currentPage = 1;

  ScrollController _scrollController = new ScrollController();
  final snackBar = SnackBar(content: Text('متاسفانه این پست لایک نشد'));
  bool _isLoading = true;
  _getPost({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });

    var response = await PostExploreService.getPosts(page);
    setState(() {
      if (refresh) _products.clear();
      _products.addAll(response['products']);
      _currentPage += 1;
      _isLoading = false;
    });
  }

  Future<Null> _handleRefresh() async {
    await _getPost(refresh: true);
    return null;
  }

  Widget streamListView() {
    return _products.length == 0 && _isLoading
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : Padding(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(_products[index]);
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => PostPicture(
                                data: _products[index],
                              ),
                            ));
                      },
                      child: samplesExplore(index, _products[index]),
                    );
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10));
  }

  @override
  void initState() {
    super.initState();
    _getPost();
  }

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
                      Container(
                        padding: EdgeInsets.only(bottom: 36),
                        child: ClipRRect(
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
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 2.5, bottom: 2.5, left: 2.5, right: 2.5),
                          margin:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(0, 2),
                                  color: Colors.black.withOpacity(0.07),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(60)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 7),
                                child: Row(
                                  children: [
                                    widget.data.likeUser.length >= 3
                                        ? Stack(
                                            children: [
                                              Positioned(
                                                  right: 7,
                                                  child: CircleAvatar(
                                                    backgroundImage: widget
                                                                .data
                                                                .likeUser
                                                                .length >=
                                                            3
                                                        ? widget.data.likeUser[
                                                                        2]
                                                                    ["image"] !=
                                                                null
                                                            ? NetworkImage(widget
                                                                    .data
                                                                    .likeUser[2]
                                                                ["image"])
                                                            : null
                                                        : null,
                                                    radius: 14,
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                  )),
                                              Positioned(
                                                  right: 21,
                                                  child: CircleAvatar(
                                                    backgroundImage: widget
                                                                .data
                                                                .likeUser
                                                                .length >=
                                                            2
                                                        ? widget.data.likeUser[
                                                                        1]
                                                                    ["image"] !=
                                                                null
                                                            ? NetworkImage(widget
                                                                    .data
                                                                    .likeUser[1]
                                                                ["image"])
                                                            : null
                                                        : null,
                                                    radius: 14,
                                                    backgroundColor:
                                                        Colors.orange[200],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 32)),
                                              Positioned(
                                                  child: CircleAvatar(
                                                backgroundImage: widget.data
                                                            .likeUser.length >=
                                                        1
                                                    ? widget.data.likeUser[0]
                                                                ["image"] !=
                                                            null
                                                        ? NetworkImage(widget
                                                                .data
                                                                .likeUser[0]
                                                            ["image"])
                                                        : null
                                                    : null,
                                                radius: 14,
                                                backgroundColor:
                                                    Colors.deepOrange[400],
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
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 5, right: 10),
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(0, 2),
                                    color: Colors.black.withOpacity(0.07),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60)),
                            child: Row(
                              children: [
                                GestureDetector(
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.grey[300],
                                      child: ClipOval(
                                        child:
                                            widget.data.author["image"] != null
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
                                                      username: widget.data
                                                          .author['username']),
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 40, left: 15),
                          alignment: Alignment.topLeft,
                          width: 50,
                          height: 80,
                          child: FittedBox(
                            child: FloatingActionButton(
                              heroTag: "btn4",
                              child: Icon(
                                Icons.chevron_left,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              backgroundColor: Colors.white,
                              elevation: 8,
                              foregroundColor: Colors.black,
                              // shape: RoundedRectangleBorder(

                              //     borderRadius: BorderRadius.circular(22)),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                height: 86,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: FloatingActionButton(
                        heroTag: "btn1",
                        child: Icon(LineIcons.bookmark),
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBarUpdate);
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(22)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    FittedBox(
                      child: FloatingActionButton(
                        heroTag: "btn2",
                        child: Icon(
                          widget.data.like == true
                              ? LineIcons.heartAlt
                              : LineIcons.heart,
                          color: widget.data.like == true
                              ? Colors.red
                              : Colors.black,
                        ),
                        onPressed: () async {
                          var likeTest =
                              await LikePost.likePost(widget.data.id);
                          // ignore: unrelated_type_equality_checks
                          likeTest == true
                              ? setState(() {
                                  widget.data.likePost();
                                })
                              : ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                        },
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(22)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    FittedBox(
                      child: FloatingActionButton(
                        heroTag: "btn3",
                        child: PopupMenuButtonPostPicture(data: widget.data),
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(22)),
                      ),
                    )
                  ],
                ),
              ),
              widget.data.alt != null
                  ? Container(
                      padding: EdgeInsets.only(top: 5, right: 20, bottom: 5),
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
                child: _products.length == 0 && _isLoading
                    ? loadingView()
                    : _products.length == 0
                        ? listIsEmpty()
                        : Padding(
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemCount: _products.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    print(_products[index]);
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => PostPicture(
                                            data: _products[index],
                                          ),
                                        ));
                                  },
                                  child:
                                      samplesExplore(index, _products[index]),
                                );
                              },
                              staggeredTileBuilder: (index) =>
                                  const StaggeredTile.fit(2),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10)),
              )
            ],
          ),
        ));
  }
}

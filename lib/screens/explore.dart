import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treaget/components/indicator_tab.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/components/explore/samplesExplore.dart';
import 'package:treaget/components/request.dart';
import 'package:treaget/screens/profile.dart';
import 'package:treaget/services/explore_service.dart';
import 'package:treaget/services/global_service.dart';
import 'package:treaget/services/profile_service.dart';
import 'package:treaget/services/request_service.dart';
import 'package:treaget/services/user_service.dart';

import '../global.dart';
import 'PostPicture.dart';

// ignore: must_be_immutable
class Example08 extends StatefulWidget {
  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<Example08>
    with AutomaticKeepAliveClientMixin<Example08> {
  List _products = [];
  List request = [];
  List users = [];
  String text;
  int tabIndex = 0;
  ScrollController _scrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true;
  int _currentPage = 1;
  int _currentPageUser = 1;
  int _currentPageRequest = 1;
  bool _isLoading = true;
  bool _isLoadingUser = true;
  bool _isLoadingRequest = true;
  Map userInfo;
  bool loadingUser = true;
  ScrollController _listScrollController = new ScrollController();

  Widget listIsEmpty() {
    return Center(
      child: Text('محصولی برای نمایش وجود ندارد'),
    );
  }

  Future<Null> _handleRefresh() async {
    await _getPost(refresh: true);
    return null;
  }

  Future<Null> _handleRefreshRequest() async {
    await _getRequest(refresh: true);
    return null;
  }

  Future<Null> _handleRefreshUsers() async {
    await _getUser(refresh: true);
    return null;
  }

  Widget streamListView() {
    return _products.length == 0 && _isLoading
        ? loadingViewCenter()
        : _products.length == 0
            ? listIsEmpty()
            : Scaffold(
                backgroundColor: Colors.white,
                body: RefreshIndicator(
                    child: Padding(
                      child: Stack(
                        children: [
                          StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            itemCount: _products.length,
                            // controller: widget._controller,
                            // controller: _scrollController,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print(_products[index]);
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => PostPicture(
                                          data: _products[index],
                                          info: userInfo,
                                        ),
                                      ));
                                },
                                child: samplesExplore(index, _products[index]),
                              );
                            },
                            staggeredTileBuilder: (index) =>
                                const StaggeredTile.fit(2),
                          ),
                          _products.length != 0 && _isLoading
                              ? loadingViewBottom()
                              : Container()
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onRefresh: _handleRefresh),
              );
  }

  _getCurrentUserInfo() async {
    var response = await CurrentUserService.information();
    if (response["result"] != false) {
      setState(() {
        loadingUser = false;
        userInfo = response["result"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStart();
  }

  getStart() async {
    await _getCurrentUserInfo();
    await _getPost();
    await _getRequest();
    await _getUser();
    await _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.hasClients) {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;

      if (maxScroll - currentScroll <= 10) {
        if (!_isLoading && tabIndex == 0) {
          if (text != null && text.isNotEmpty) {
            serachPost(page: _currentPage);
          } else {
            _getPost(page: _currentPage + 1);
          }
        } else if (!_isLoadingUser && tabIndex == 2) {
          if (text != null && text.isNotEmpty) {
            searchUser(page: _currentPageUser + 1);
          } else {
            _getUser(page: 1);
          }
        } else if (!_isLoadingUser && tabIndex == 1) {
          if (text != null && text.isNotEmpty) {
            searchRequest(page: _currentPageRequest + 1);
          } else {
            _getRequest(page: _currentPageRequest + 1);
          }
        }
      }
    }
  }

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

  serachPost({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });

    var response = await PostExploreService.search(page: page, text: text);
    setState(() {
      if (refresh) _products.clear();
      _products.addAll(response['products']);
      _currentPage += 1;
      _isLoading = false;
    });
  }

  searchUser({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoadingUser = true;
    });

    var response = await UserApi.SearchUser(text: text, page: page);
    setState(() {
      if (refresh) users.clear();
      users.addAll(response['results']);
      _currentPageUser += 1;
      _isLoadingUser = false;
    });
  }

  _getUser({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoadingUser = true;
    });

    var response = await UserApi.randomUser();
    setState(() {
      if (refresh) users.clear();
      users.addAll(response['results']);
      _isLoadingUser = false;
    });
  }

  searchRequest({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoadingRequest = true;
    });
    var response = await RequestApi.search(text: text, page: page);

    setState(() {
      if (refresh) request.clear();
      if (response['data'] != false) request.addAll(response['data']);
      _currentPageRequest += 1;
      _isLoadingRequest = false;
    });
  }

  _getRequest({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoadingRequest = true;
      _currentPage += 1;
    });

    var response = await RequestApi.explore(page: page);

    setState(() {
      if (refresh) request.clear();
      if (response['data'] != false) request.addAll(response['data']);
      _isLoadingRequest = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [topPage()];
        },
        controller: _scrollController,
        body: Container(
            child: DefaultTabController(
                length: 3,
                child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: PreferredSize(
                        preferredSize: Size.fromHeight(50.0),
                        // elevation: 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TabBar(
                              onTap: (index) {
                                setState(() {
                                  tabIndex = index;
                                });
                              },
                              isScrollable: false,
                              indicatorColor: Colors.black,
                              labelColor: Color(0xffE94A28),
                              unselectedLabelColor: Colors.grey[700],
                              indicator: MD2Indicator(
                                indicatorSize: MD2IndicatorSize.normal,
                                indicatorHeight: 3,
                                indicatorColor: Color(0xffE94A28),
                              ),
                              tabs: <Widget>[
                                Tab(
                                  child: Text("  نمونه کار"),
                                ),
                                Tab(
                                  child: Text("درخواست ها  "),
                                ),
                                Tab(
                                  child: Text("کاربر ها"),
                                ),
                              ],
                            ),
                            Divider(height: 0, color: Colors.grey[300])
                            // Padding(padding: EdgeInsets.only(bottom: 6))
                          ],
                        )),
                    body: TabBarView(children: [
                      Container(
                        child: streamListView(),
                      ),
                      RefreshIndicator(
                          onRefresh: _handleRefreshRequest,
                          child: request.length == 0 && _isLoadingRequest
                              ? loadingViewCenter()
                              : request.length == 0
                                  ? listIsEmpty()
                                  : Container(
                                     
                                      child: Stack(
                                        children: [
                                          ListView.builder(
                                            itemCount: request.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {if(index == 0 ){return Padding(padding: EdgeInsets.only(top: 10),child:RequestCardComponent(
                                                  request[index],
                                                  userInfo,
                                                  false) ,);} else{
                                              return RequestCardComponent(
                                                  request[index],
                                                  userInfo,
                                                  false);}
                                            },
                                          ),
                                          request.length != 0 &&
                                                  _isLoadingRequest
                                              ? loadingViewBottom()
                                              : Container()
                                        ],
                                      ))),
                      RefreshIndicator(
                          onRefresh: _handleRefreshUsers,
                          child: users.length == 0 && _isLoadingUser
                              ? loadingViewCenter()
                              : users.length == 0
                                  ? listIsEmpty()
                                  : Padding(
                                      padding:
                                          EdgeInsets.only(right: 5, left: 5),
                                      child: Stack(
                                        children: [
                                          GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  MediaQuery.of(context)
                                                              .orientation ==
                                                          Orientation.landscape
                                                      ? 3
                                                      : 2,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8,
                                              childAspectRatio: (1),
                                            ),
                                            itemCount: users.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (index == 0 || index == 1) {
                                                return Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: userList(users[index]),
                                                );
                                              } else {
                                                return userList(users[index]);
                                              }
                                            },
                                          ),
                                          users.length != 0 && _isLoadingUser
                                              ? loadingViewBottom()
                                              : Container()
                                        ],
                                      ))),
                    ])))));
  }

  Widget topPage() {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              elevation: 0,
              title: Row(
                textDirection: TextDirection.rtl,
                children: [],
              ),
            ),
            loadingUser == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: CircleAvatar(
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.grey[100],
                                  backgroundImage: userInfo['image'] != null
                                      ? NetworkImage("${userInfo['image']}")
                                      : null,
                                )),
                            backgroundColor: Color(0xffE94A28),
                            radius: 26,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(right: 20),
                              child: Row(
                                children: [
                                  Text(
                                    "👋عزیز سلام ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "${userInfo['first_name']}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Text("   به تریگت خوش آمدی",
                                style: TextStyle(fontSize: 14)),
                          )
                        ],
                      ),
                    ],
                  )
                : Text(""),
            Form(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        top: 50, bottom: 0, left: 20, right: 20),
                    child: TextFormField(
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (var value) {
                        setState(() {
                          text = value;
                          _currentPage = 1;
                          _currentPageUser = 1;
                          _currentPageRequest = 1;
                        });

                        if (value != null && value.isNotEmpty) {
                          serachPost(refresh: true);
                          searchUser(refresh: true);
                          searchRequest(refresh: true);
                        } else {
                          _handleRefreshUsers();
                          _handleRefresh();
                          _handleRefreshRequest();
                        }
                      },
                      decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          icon: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(0, 5),
                                    color: Color(0xffE94A28).withOpacity(0.2),
                                  )
                                ],
                                gradient: LinearGradient(colors: [
                                  Color(0xffE94A28),
                                  Color(0xffE52C2C)
                                ]),
                                borderRadius: BorderRadius.circular(17)),
                            child: Icon(
                              LineIcons.search,
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          hintText: "search",
                          hintStyle: TextStyle(fontSize: 15),
                          contentPadding: EdgeInsets.only(
                              top: 5, right: 10, bottom: 5, left: 20)),
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userList(data) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => Scaffold(
                    body: Profile(username: data['username']),
                    backgroundColor: Colors.white,
                  ))),
      child: Container(
        width: double.infinity,

        // margin: EdgeInsets.only(bottom: 30, right: 5, left: 5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: data["image"] != null
                    ? CachedNetworkImage(
                        imageUrl: "${data['image']}",
                        fit: BoxFit.cover,
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
                        })
                    : Image(
                        image: AssetImage(("assets/images/avatar.png")),
                      )),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.topRight,
                // width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 0, top: 20),
                      height: 79,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data["postPicture"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 3),
                                  borderRadius: BorderRadius.circular(9)),
                              margin:
                                  EdgeInsets.only(bottom: 0, left: 5, top: 40),
                              width: 39,
                              child: Opacity(
                                opacity: 0.9,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            "${data["postPicture"][index]["image"]}",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(.5)),
                                          );
                                        })),
                              ),
                            );
                          }),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 0, left: 15, top: 4),
                      child: Text(
                        "${data['username']}",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Container(
                        // width: double.infinity,
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Container(
                          margin: EdgeInsets.only(
                            bottom: 5,
                            left: 15,
                          ),
                          child: Text(
                            data["bio"] != null ? "${data['bio']}" : "",
                            style: TextStyle(
                                color: Colors.white.withOpacity(.7),
                                fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                        Flexible(
                            child: Container(
                          margin: EdgeInsets.only(
                            bottom: 5,
                            right: 8,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 4),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              data["ServiceProvider"] == true
                                  ? " فریلنسر "
                                  : " کارفرما",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ))
                      ],
                    )),
                  ],
                ),
                // height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(.9),
                          Colors.black.withOpacity(.7),
                          Colors.black.withOpacity(.3),
                          Colors.black.withOpacity(0)
                        ])),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,

          // borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

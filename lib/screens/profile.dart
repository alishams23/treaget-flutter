// import 'dart:html';
import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/components/profile/sampleProfile.dart';
import 'package:treaget/screens/profile/services.dart';
import 'package:treaget/screens/profile/timeLine.dart';
import 'package:treaget/services/profile_service.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  List _products = [];
  List resume = [];
  List service = [];
  Map info = {};
  int _currentPage = 1;
  bool _isLoading = true;

  ScrollController _scrollController;

  Future<Null> _handleRefresh() async {
    await _getPost(refresh: true);
    return null;
  }

  Future<Null> _handleRefreshService() async {
    await getService();
    return null;
  }

  Future<Null> _handleRefreshResume() async {
    await _getResume();
    return null;
  }

  _getPost({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await PostPictureProfileService.getPosts();
    setState(() {
      if (refresh) _products.clear();
      _products.addAll(response['products']);
      _currentPage = response["current_page"];
      _isLoading = false;
    });
  }

  _getInformaion({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await InformationProfileService.getInfo();
    setState(() {
      info.clear();
      info.addAll(response);
      _isLoading = false;
    });
  }

  getService({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await ServiceProfileService.getService();
    setState(() {
      service.clear();
      service.addAll(response['data']);
      _isLoading = false;
    });
  }

  _getResume({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await TimelineProfileService.getResume();
    setState(() {
      resume.clear();
      resume.addAll(response['data']);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPost();
    _getInformaion();
    _getResume();
    getService();
  }

  Widget listIsEmpty() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            alignment: Alignment.center,
            child: Text('چیزی برای نمایش وجود ندارد'));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        body: Container(
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  elevation: 0,
                  flexibleSpace: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabBar(
                        isScrollable: false,
                        indicatorColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor: Colors.grey[400],
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 25,
                              offset: Offset(0, 15),
                            ),
                          ],
                        ),
                        tabs: <Widget>[
                          Tab(
                            icon: Icon(Icons.dashboard_outlined),
                          ),
                          Tab(
                            icon: Icon(Icons.assignment_ind_outlined),
                          ),
                          Tab(
                            icon: Icon(Icons.store_outlined),
                          ),
                        ],
                      ),
                    ],
                  )),
              body: TabBarView(
                children: [
                  _products.length == 0 && _isLoading
                      ? loadingView()
                      : _products.length == 0
                          ? RefreshIndicator(
                              onRefresh: _handleRefresh, child: listIsEmpty())
                          : Scaffold(
                              floatingActionButton:
                                  FloatingActionButton.extended(
                                onPressed: () {
                                  // Add your onPressed code here!
                                },
                                label: Text("سفارش"),
                                icon: Icon(Icons.shopping_bag_outlined),
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.grey[200],
                              ),
                              body: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 4),
                                child: RefreshIndicator(
                                    onRefresh: _handleRefresh,
                                    child: StaggeredGridView.countBuilder(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                      itemCount: _products.length,
                                      itemBuilder: (context, index) {
                                        return SampleProfile(
                                            index, _products[index]);
                                      },
                                      staggeredTileBuilder: (index) =>
                                          const StaggeredTile.fit(2),
                                    )),
                              )),
                  RefreshIndicator(
                      onRefresh: _handleRefreshResume,
                      child: resume.length == 0 && _isLoading
                          ? loadingView()
                          : resume.length == 0
                              ? listIsEmpty()
                              : ListView.builder(
                                  itemCount: resume.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TimeLineProfile(
                                        index: index, data: resume[index]);
                                  },
                                )),
                  RefreshIndicator(
                      onRefresh: _handleRefreshService,
                      child: service.length == 0 && _isLoading
                          ? loadingView()
                          : service.length == 0
                              ? listIsEmpty()
                              : Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: ListView.builder(
                                    itemCount: service.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Services(
                                        data: service[index],
                                      );
                                    },
                                  ),
                                ))
                ],
              ),
            ),
          ),
        ),
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [topPage(info)];
        });
  }
}

Widget topPage(Map info) {
  return SliverToBoxAdapter(
    child: Container(
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            title: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Directionality(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  info.length != 0
                                      ? info['first_name'] +
                                          ' ' +
                                          info['last_name']
                                      : '',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  info.length != 0 ? info['username'] : ' ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: PopupMenuButtonProfile())),
                                      Padding(
                                          padding: EdgeInsets.only(right: 6)),
                                      Expanded(
                                          flex: 7,
                                          child: Container(
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                shadowColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets.all(0)),
                                              ),
                                              child: Container(
                                                width: 300,
                                                decoration: new BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xff004e92),
                                                      Color(0xff0664bb)
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 1,
                                                      blurRadius: 19,
                                                      offset: Offset(0, 9),
                                                    )
                                                  ],
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  "دنبال کردن",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            textDirection: TextDirection.ltr,
                          )),
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: Container(
                        child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(43.0),
                              child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 19,
                                    offset: Offset(0, 9),
                                  )
                                ]),
                                child: info.length != 0
                                    ? Image.network(
                                        info['image'],
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/Gradient.jpg",
                                        fit: BoxFit.cover,
                                      ),
                              ))),
                    )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Text(
              info.length != 0 ? info['bio'] : ' ',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      info.length != 0 ? '${info["followers"].length}' : '0',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "دنبال کننده",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: Colors.grey[100]),
                  height: 37,
                  width: 2,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      info.length != 0 ? '${info["following"].length}' : '0',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "دنبال شونده",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class PopupMenuButtonProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.2)),
          ),
          child: Icon(
            LineIcons.horizontalEllipsis,
            color: Colors.black,
          )),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.black,
            ),
            title: Text(
              "ارسال پیام",
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.payment,
              color: Colors.black,
            ),
            title: Text(
              "پرداخت امن",
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            title: Text(
              'ثبت سفارش',
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.share,
              color: Colors.blue,
            ),
            title: Text(
              "اشتراک گذاری پروفایل",
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines/timelines.dart';
import 'package:treaget/components/indicator_tab.dart';
import 'package:treaget/components/indicator_tab_circle.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/components/explore/samplesExplore.dart';
import 'package:treaget/services/explore_service.dart';

// ignore: must_be_immutable
class Example08 extends StatefulWidget {
  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<Example08>
    with AutomaticKeepAliveClientMixin<Example08> {
  List _products = [];
  ScrollController _scrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true;
  int _currentPage = 1;
  bool _isLoading = true;
  ScrollController _listScrollController = new ScrollController();

  Widget listIsEmpty() {
    return Text('محصولی برای نمایش وجود ندارد');
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
            : Scaffold(
                backgroundColor: Colors.white,
                body: RefreshIndicator(
                    child: Padding(
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        itemCount: _products.length,
                        // controller: widget._controller,
                        // controller: _scrollController,
                        itemBuilder: (context, index) {
                          return samplesExplore(index, _products[index]);
                        },
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(2),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onRefresh: _handleRefresh),
              );
  }

  @override
  void initState() {
    super.initState();
    _getPost();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.hasClients) {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;

      if (maxScroll - currentScroll <= 200) {
        if (!_isLoading) {
          _getPost(page: _currentPage + 1);
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
      _currentPage = response["current_page"];
      _isLoading = false;
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
                    appBar: AppBar(
                        elevation: 0,
                        flexibleSpace: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TabBar(
                              // isScrollable: true,
                              indicatorColor: Colors.black,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey[500],
                              indicator: CircleTabIndicator(color: Colors.black, radius: 3),
                              // indicator: CircleTabIndicator(color: Colors.green, radius: 4),
                              tabs: <Widget>[
                                Tab(
                                  // icon: Icon(Icons.cloud_outlined),
                                  child: Text("نمونه کار"),
                                ),
                                Tab(
                                  // icon: Icon(Icons.beach_access_sharp),
                                  child: Text("درخواست ها"),
                                ),
                                Tab(
                                  // icon: Icon(Icons.beach_access_sharp),
                                  child: Text("خدمات ها"),
                                ),
                              ],
                            ),
                          ],
                        )),
                    body: TabBarView(children: [
                      Container(
                        child: streamListView(),
                      ),
                      Center(
                        child: Text('It\'s sunny here'),
                      ),
                      Center(
                        child: Text('It\'s sunny here'),
                      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ),
            Text(
              "explore",
              style: TextStyle(fontSize: 20),
            ),
            Form(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 20, right: 20),
                    child: TextFormField(
                      decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          icon: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(17)),
                            child: Icon(
                              LineIcons.horizontalSliders,
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
}

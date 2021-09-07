import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines/timelines.dart';
import 'package:treaget/components/indicator_tab.dart';
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
  ScrollController _scrollController;
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
    return 
        _products.length == 0 && _isLoading
            ? loadingView()
            : _products.length == 0
                ? listIsEmpty()
                :  Scaffold(body: RefreshIndicator(
                    child: Padding(
                      child: StaggeredGridView.countBuilder(
                    
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        itemCount: _products.length,
                        // controller: widget._controller,
                        // controller: _listScrollController,
                        itemBuilder: (context, index) {
                          return samplesExplore(index, _products[index]);
                        },
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(2),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onRefresh: _handleRefresh),);
  }

  @override
  void initState() {
    super.initState();
    _getPost();

    _scrollController.addListener(() {
      // double maxScroll = _listScrollController.position.maxScrollExtent;
      // double currentScroll = _listScrollController.position.pixels;

      // if (maxScroll - currentScroll <= 200) {
      //   if (!_isLoading) {
      //     _getPost(page: _currentPage + 1);
      //   }
      // }
    });
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
                length: 2,
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
                                  // icon: Icon(Icons.cloud_outlined),
                                  child: Text("نمونه کار"),
                                ),
                                Tab(
                                  // icon: Icon(Icons.beach_access_sharp),
                                  child: Text("درخواست ها"),
                                ),
                              ],
                            ),
                          ],
                        )),
                    body: TabBarView(children: [
                      Container(child: streamListView(),),
                      Center(
                        child: Text('It\'s sunny here'),
                      ),
                    ])))));
  }
Widget topPage() {
  return SliverToBoxAdapter(
    child: Container(
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            title: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("data")],
            ),
          ),
           Text("data"),                 ],
      ),
    ),
  );
}


  // @override
  // Widget buildnew(BuildContext context) {
  //   return DefaultTabController(
  //     initialIndex: 0,
  //     length: 2,
  //     child: Scaffold(
  //       backgroundColor: Colors.white,
  //       floatingActionButton: FloatingActionButton(
  //         backgroundColor: Colors.grey[200],
  //         foregroundColor: Colors.black,
  //         onPressed: () {},
  //         child: Icon(LineIcons.search),
  //       ),
  //       appBar: AppBar(
  //         elevation: 1,
  //         backgroundColor: Colors.white,
  //         // title: const Text('TabBar Widget'),
  //         flexibleSpace: Column(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             TabBar(
  //               // isScrollable: true,
  //               // indicatorColor: Colors.black,
  //               unselectedLabelColor: Colors.grey,
  //               indicator: MD2Indicator(
  //                 indicatorSize: MD2IndicatorSize.normal,
  //                 indicatorHeight: 2.0,
  //                 indicatorColor:
  //                     _isLoading == false ? Colors.black : Colors.transparent,
  //               ),
  //               tabs: <Widget>[
  //                 Tab(
  //                   // icon: Icon(Icons.cloud_outlined),
  //                   child: Text("نمونه کار"),
  //                 ),
  //                 Tab(
  //                   // icon: Icon(Icons.beach_access_sharp),
  //                   child: Text("درخواست ها"),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       body: TabBarView(
  //         children: <Widget>[
  //           streamListView(),
  //           Center(
  //             child: Text('It\'s sunny here'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

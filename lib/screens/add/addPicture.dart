import 'package:flutter/material.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/services/orders_service.dart';

class AddPicture extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AddPictureState();
  
}

class AddPictureState extends State{

  // bool _isLoading;
  // ScrollController _listScrollController = new ScrollController();
  // List orders = [];
  // int _currentPage = 1;

  // _getPost({int page: 1, bool refresh: false}) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   var response = await OrdersService.getOrders(page);
  //   setState(() {
  //     if (refresh) orders.clear();
  //     if (response['results'] != null) {
  //       orders.addAll(response['results']);
  //       _currentPage = page;
  //     }
  //     _isLoading = false;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Text("data"),);
  }
  
}
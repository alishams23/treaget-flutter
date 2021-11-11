import 'package:flutter/material.dart';
import 'package:treaget/components/empty.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/components/safepayment.dart';
import 'package:treaget/services/safePayment_service.dart';

class SafePayments extends StatefulWidget {
  Map info = {};
  SafePayments({this.info});
  @override
  State<StatefulWidget> createState() => StateSafePayments();
}

class StateSafePayments extends State<SafePayments> {
  List data = [];
  bool _isLoading = true;
  _getSafePaymentList({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await SafePaymentService.list();

    setState(() {
      if (refresh) data.clear();
      if (response['result'] != null) {
        data.addAll(response['result']);
      }
      _isLoading = false;
    });
  }

    @override
  void initState() {
    super.initState();
    _getSafePaymentList();
  }

  Future<Null> _handleRefresh() async {
    await _getSafePaymentList(refresh: true);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          data != null
              ? RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SafePayment(data: data[index],currntUser: widget.info,handleRefresh: _handleRefresh,);
                      }),
                )
              : listIsEmpty(),
          _isLoading == true ? loadingView() : Container()
        ],
      ),
    );
  }
}

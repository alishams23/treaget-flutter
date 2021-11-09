import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/components/indicator_tab.dart';
import 'package:treaget/screens/dashboard/disputes.dart';
import 'package:treaget/services/profile_service.dart';
import 'package:treaget/components/loading.dart';

import 'dashboard/mainDashboard.dart';
import 'dashboard/notification.dart';
import 'dashboard/orders.dart';
import 'dashboard/safePayments.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardWidgetState();
}

class DashboardWidgetState extends State {
  Map info = {};
  bool _isLoading = true;

_getInformaion({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await InformationProfileService.getInfo(
        username: "");
    setState(() {
      info.clear();
      info.addAll(response);
      _isLoading = false;
    });

    
  }
  @override
  void initState() {_getInformaion();}
  @override
  Widget build(BuildContext context) {
    return info!= {}? DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.4,
          backgroundColor: Colors.white,
          // title: const Text('TabBar Widget'),

          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                
                isScrollable: true,
                // indicatorColor: Colors.black,
                 labelColor: Color(0xffE94A28),
                              unselectedLabelColor: Colors.grey[700],
                              indicator: MD2Indicator(
                                indicatorSize: MD2IndicatorSize.normal,
                                indicatorHeight: 3,
                                indicatorColor: Color(0xffE94A28),
                ),
                tabs: <Widget>[
                  Tab(
                    // icon: Icon(Icons.cloud_outlined),
                    child: Text("میزکار"),
                  ),
                  Tab(
                    // icon: Icon(Icons.beach_access_sharp),
                    child: Text("نوتیفیکیشن"),
                  ),
                  Tab(
                    // icon: Icon(Icons.brightness_5_sharp),
                    child: Text("سفارشات شما"),
                  ),
                  Tab(
                    // icon: Icon(Icons.brightness_5_sharp),
                    child: Text("پرداخت های امن"),
                  ),
                  Tab(
                    // icon: Icon(Icons.brightness_5_sharp),
                    child: Text("اختلافات"),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DashboardMain(),
            NotificationApp(),
            Orders(info:info),
            SafePayments(info: info,),
            Disputes(),
          ],
        ),
      ),
    ):loadingViewCenter();
  }
}

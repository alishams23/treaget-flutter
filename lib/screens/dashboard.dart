import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/components/indicator_tab.dart';
import 'package:treaget/screens/dashboard/disputes.dart';

import 'dashboard/mainDashboard.dart';
import 'dashboard/notification.dart';
import 'dashboard/orders.dart';
import 'dashboard/safePayment.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          // title: const Text('TabBar Widget'),

          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                isScrollable: true,
                // indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[400],
                indicator: MD2Indicator(
                  indicatorSize: MD2IndicatorSize.normal,
                  indicatorHeight: 3,
                  indicatorColor:  Colors.black,
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
            Orders(),
            SafePayment(),
            Disputes(),
          ],
        ),
      ),
    );
  }
}

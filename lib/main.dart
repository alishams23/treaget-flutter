import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/screens/dashboard.dart';
import 'package:treaget/screens/explore.dart';
import 'package:treaget/screens/home.dart';
import 'package:treaget/screens/profile.dart';
// import 'package:badges/badges.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        builder: (context, child) {
          return Directionality(textDirection: TextDirection.ltr, child: child);
        },
        title: 'treaget',
        theme: ThemeData(primaryColor: Colors.white, fontFamily: "Vazir"),
        debugShowCheckedModeBanner: false,
        home: Example());
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    FeedScreen(),
    Example08(),
    DashboardWidget(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.black.withOpacity(.2),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100],
              color: Colors.grey[500],
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'خانه',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'کاوش',
                ),
                GButton(
                  icon: LineIcons.horizontalSliders,
                  text: 'میز کار',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'پروفایل',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

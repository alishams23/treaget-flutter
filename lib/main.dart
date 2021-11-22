import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/screens/dashboard.dart';
import 'package:treaget/screens/explore.dart';
import 'package:treaget/screens/home.dart';
import 'package:treaget/screens/login.dart';
import 'package:treaget/screens/profile.dart';
import 'package:treaget/screens/register.dart';
import 'package:treaget/screens/splash.dart';
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
      title: 'تریگت',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: "Vazir",
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white, foregroundColor: Colors.black),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return CupertinoPageRoute(
                builder: (_) => Example(), settings: settings);
        }
      },
      routes: {
        "/": (context) => new SplashScreen(),
        // "/home": (context) => Example(),
        "/profile": (context) => Example(
              selectedIndex: 3,
            ),
        "/login": (context) => new Directionality(
            textDirection: TextDirection.rtl, child: new LoginScreen()),
        "/register": (context) =>
            Directionality(textDirection: TextDirection.rtl, child: Register())
        // "/setting" : (context) => new SettingScreen(),
        // "/new_chat" : (context) => new CreateChatScreen()
      },
    );
  }
}

class Example extends StatefulWidget {
  int selectedIndex;

  Example({this.selectedIndex = 1});
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  static List<Widget> _widgetOptions = <Widget>[
    FeedScreen(),
    Example08(),
    DashboardWidget(),
    Profile(),
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: IndexedStack(children: <Widget>[
          _widgetOptions.elementAt(0),
          _widgetOptions.elementAt(1),
          _widgetOptions.elementAt(2),
          _widgetOptions.elementAt(3),
        ], index: widget.selectedIndex),
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
              // rippleColor: Colors.grey[100],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              tabBackgroundGradient: LinearGradient(
                  colors: [Color(0xffE94A28), Color(0xffE52C2C)]),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              tabBorderRadius: 30,
              duration: Duration(milliseconds: 200),
              tabBackgroundColor: Colors.grey[100],
              color: Colors.grey[500],
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'خانه',
                  shadow: widget.selectedIndex == 0
                      ? [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                            color: Color(0xffE94A28).withOpacity(0.4),
                          )
                        ]
                      : [],
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'کاوش',
                  shadow: widget.selectedIndex == 1
                      ? [
                          BoxShadow(
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                            color: Color(0xffE94A28).withOpacity(0.3),
                          )
                        ]
                      : [],
                ),
                GButton(
                  icon: LineIcons.horizontalSliders,
                  text: 'میز کار',
                  shadow: widget.selectedIndex == 2
                      ? [
                          BoxShadow(
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                            color: Color(0xffE94A28).withOpacity(0.3),
                          )
                        ]
                      : [],
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'پروفایل',
                  shadow: widget.selectedIndex == 3
                      ? [
                          BoxShadow(
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                            color: Color(0xffE94A28).withOpacity(0.3),
                          )
                        ]
                      : [],
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  widget.selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

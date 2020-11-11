import 'package:flutter/material.dart';
import 'package:flutter_robinhood/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home_screen.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _page = 0;
  List<Widget> _screens = [
    HomeScreen(),
    Container(
      child: Center(
        child: Text(
          "Wallet",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          "Messages",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          "Account",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _screens[_page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Styles.color_background,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => setState(() => _page = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.chartLine,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.wallet,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.magnify,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.messageOutline,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.accountOutline,
              size: 25,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

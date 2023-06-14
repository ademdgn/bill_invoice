import 'package:bill_invoice/Pages/BillPage/BillAddPage.dart';
import 'package:bill_invoice/Pages/BillPage/BillHistory.dart';
import 'package:bill_invoice/Pages/HomePage/HomePage.dart';
import 'package:bill_invoice/Pages/UserPage/UserPage.dart';
import 'package:bill_invoice/Storage_Service/Firebase_Storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  Storage storage = Storage();
  int selectIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BillAddPage(),
    BillHistory(),
    UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: GNav(
          gap: 2,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.black,
          tabBackgroundColor: Colors.white70,
          padding: EdgeInsets.all(15),
          tabs: const [
            GButton(icon: Icons.home, text: "Home"),
            GButton(
              icon: Icons.add,
              text: "Bill Add",
            ),
            GButton(icon: Icons.payments_outlined, text: "Paid Bill"),
            GButton(icon: Icons.person, text: "Profil"),
          ],
          selectedIndex: selectIndex,
          onTabChange: (index) {
            setState(() {
              selectIndex = index;
            });
          },
        ),
      ),
      body: _widgetOptions.elementAt(selectIndex),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food/views/cart_view.dart';
import 'package:food/views/chat_view.dart';
import 'package:food/views/home_view.dart';
import 'package:food/views/profile_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationBarView extends StatefulWidget {
  BottomNavigationBarView({super.key});
  static String id = 'BottomNavBar';

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int currentIndex = 0;

  List<Widget> views = [
    HomeView(),
    ProfileView(),
    CartView(),
    ChatView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        views.elementAt(currentIndex),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 50,
                    color: Colors.grey.shade200,
                    spreadRadius: 3,
                    offset: Offset(0, 0)),
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: GNav(
                  onTabChange: (value) {
                    currentIndex = value;
                    setState(() {});
                  },
                  tabBackgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.2),
                  activeColor: Theme.of(context).primaryColor,
                  tabMargin: EdgeInsets.all(10),
                  gap: 8,
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                  tabBorderRadius: 15,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(40),
                  curve: Curves.easeInQuart,
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                      padding: EdgeInsets.all(15),
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                      padding: EdgeInsets.all(15),
                    ),
                    GButton(
                      icon: Icons.shopping_cart,
                      text: 'Cart',
                      padding: EdgeInsets.all(15),
                    ),
                    GButton(
                      icon: Icons.message,
                      text: 'Chat',
                      padding: EdgeInsets.all(15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

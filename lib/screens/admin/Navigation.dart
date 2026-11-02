import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin/Book.dart';
import 'package:flutter_application_1/screens/admin/Homescreen.dart';
import 'package:flutter_application_1/screens/admin/ProfileAdmin.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  int selectindex = 0;

  final List<Widget> Screens = [Homescreen(), BookPage(), adminprof()];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[selectindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        onTap: (value) {
          selectindex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: Colors.white),
            label: 'Book',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

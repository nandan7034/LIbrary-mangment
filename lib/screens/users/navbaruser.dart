import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin/ProfileAdmin.dart';
import 'package:flutter_application_1/screens/users/bookScreen.dart';
import 'package:flutter_application_1/screens/users/homeScreenUser.dart';
import 'package:flutter_application_1/screens/users/issuedBook.dart';
import 'package:flutter_application_1/screens/users/profile.dart';

class Navbaruser extends StatefulWidget {
  const Navbaruser({super.key});

  @override
  State<Navbaruser> createState() => _NavbaruserState();
}

class _NavbaruserState extends State<Navbaruser> {
  final List<Widget> screens = [
    LibraryHome(),
    BookDetails(),
    Issuedbook(),
    Profile(),
  ];
  int currentscreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentscreen,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,

        onTap: (value) {
          setState(() {
            currentscreen = value;
          });
        },
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey.shade400,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Book"),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_add),
            label: 'My Books',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: screens[currentscreen],
    );
  }
}

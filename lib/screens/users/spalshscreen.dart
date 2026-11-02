import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/screens/admin/Navigation.dart';

import 'package:flutter_application_1/screens/users/login.dart';
import 'package:flutter_application_1/screens/users/navbaruser.dart';

class Spalshscreen extends StatefulWidget {
  const Spalshscreen({super.key});

  @override
  State<Spalshscreen> createState() => _SpalshscreenState();
}

class _SpalshscreenState extends State<Spalshscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Authgate()),
        (route) => false,
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF4F6F5A),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF5D7A67).withOpacity(0.2),
                Color(0xFF4F6F5A).withOpacity(0.8),
                Color(0xFF3E5B49).withOpacity(1),
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 140),
              Text(
                'Libro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: .bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rediscover What You Know ',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 600,
                  child: Image.asset('assets/images/spl-removebg-preview.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Authgate extends StatefulWidget {
  const Authgate({super.key});

  @override
  State<Authgate> createState() => _AuthgateState();
}

class _AuthgateState extends State<Authgate> {
  Future<Widget> getRole() async {
    final user = FirebaseAuth.instance.currentUser;
    // for getting user role
    final userRole = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    if (userRole.exists) {
      return Navbaruser();
    }
    final adminRole = await FirebaseFirestore.instance
        .collection("admin")
        .doc(user.uid)
        .get();

    if (adminRole.exists) {
      return NavBar();
    }
    return Login();
  }

  late Future<Widget> roleFuture;

  @override
  void initState() {
    super.initState();
    roleFuture = getRole();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: roleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return Login();
        }
      },
    );
  }
}

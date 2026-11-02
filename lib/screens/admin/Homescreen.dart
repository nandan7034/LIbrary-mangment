import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin/Addpage.dart';
import 'package:flutter_application_1/screens/users/login.dart';
import 'package:flutter_application_1/service/FireServiceAuth.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addpage()),
          );
        },
        backgroundColor: Colors.amber.shade300,
        splashColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.add, color: Colors.black),
        ),
      ),
      backgroundColor: const Color(0xFF111111),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.menu, color: Colors.white),
                  const SizedBox(width: 10),
                  const Text(
                    "Library Pro",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB7C3FF),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      await FireserviceA().Signout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                "System Overview",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB7C3FF),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Real-time insights for Library Pro administrators.",
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: ListView(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("books")
                          .get()
                          .asStream(),
                      builder: (context, asyncSnapshot) {
                        if (!asyncSnapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return dashboardCard(
                          icon: Icons.library_books_outlined,
                          title: "TOTAL BOOKS",
                          value: asyncSnapshot.data!.docs.length.toString(),
                          badgeText: "+12%",
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .get(),
                      builder: (context, asyncSnapshot) {
                        if (!asyncSnapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return dashboardCard(
                          icon: Icons.people_outline,
                          title: "TOTAL USERS",
                          value: asyncSnapshot.data!.docs.length.toString(),
                          badgeText: "Active",
                          badgeColor: Colors.amber,
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2327A8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.bookmark, color: Colors.amber),
                          SizedBox(height: 20),
                          Text(
                            "ISSUED BOOKS",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "1,240",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC7A114),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.black),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "AVAILABLE BOOKS",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "95% Stock",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboardCard({
    required IconData icon,
    required String title,
    required String value,
    required String badgeText,
    Color badgeColor = const Color(0xFF283593),
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFB7C3FF)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(badgeText, style: const TextStyle(fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

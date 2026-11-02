import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Issuedbook extends StatefulWidget {
  Issuedbook({super.key});

  @override
  State<Issuedbook> createState() => _IssuedbookState();
}

class _IssuedbookState extends State<Issuedbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        elevation: 0,
        centerTitle: true,
        leading: Icon(Icons.menu, color: Colors.white),
        title: Text(
          "LiBro",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("bookrequest")
            .where('adminAccept', isEqualTo: 1)
            .snapshots(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final data = asyncSnapshot.data!.docs;
          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data.length == 0) {
                return Center(
                  child: Text(
                    "No Date Found",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              final formatter = DateFormat("d/M/yyyy");

              DateTime issuedDate = formatter.parse(data[index]['startDate']);
              DateTime finalDate = formatter.parse(data[index]['daysYouNeed']);

              Duration remaining = finalDate.difference(issuedDate);

              bool isExpired = finalDate.isBefore(DateTime.now());
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade800),
                    color: Colors.black12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              data[index]['url'],
                              height: 180,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]['bookName'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Author Name",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Divider(color: Colors.white),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      isExpired
                                          ? "Expired"
                                          : "${remaining.inDays} days left",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

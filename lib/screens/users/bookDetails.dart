import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/bookrequest.dart';
import 'package:flutter_application_1/service/FireService.dart';
import 'package:intl/intl.dart';

class Selectedbooks extends StatefulWidget {
  const Selectedbooks({
    super.key,
    required this.url,
    required this.bookName,
    required this.bookAuthor,
    required this.imageUrl,
    required this.bookId,
  });
  final String url;
  final String bookName;
  final String bookAuthor;
  final String imageUrl;
  final String bookId;

  @override
  State<Selectedbooks> createState() => _SelectedbooksState();
}

class _SelectedbooksState extends State<Selectedbooks> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final fromdate = TextEditingController();
  final todate = TextEditingController();
  final number = TextEditingController();

  DateTime? issueDate;
  DateTime? returnDate;
  String i = "+91";

  Future<void> datePick(bool isIssueDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (picked != null) {
      String date = "${picked.day}/${picked.month}/${picked.year}";
      print(date);

      setState(() {
        if (isIssueDate) {
          issueDate = picked;
          fromdate.text = date;
        } else {
          returnDate = picked;
          todate.text = date;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                ),

                SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bookName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        widget.bookAuthor,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Text(
              'ddd',
              style: TextStyle(
                height: 1.6,
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade800),
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "From Date",
                        style: TextStyle(color: Colors.white60),
                      ),

                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: fromdate,
                          readOnly: true,
                          onTap: () => datePick(true),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Select date",
                          ),
                        ),
                      ),
                      Text(
                        "   To Date",
                        style: TextStyle(color: Colors.white60),
                      ),

                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: todate,
                          readOnly: true,

                          onTap: () => datePick(false),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Select date",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Text(
                    textAlign: TextAlign.start,
                    "Enter Your Number",
                    style: TextStyle(color: Colors.white60),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "+91",
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: InkWell(
                      onTap: () async {
                        // String formattedDate = DateFormat('d/M/yyyy').format(DateTime.now());
                        if (issueDate == null || returnDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select both dates")),
                          );
                          return;
                        }
                        DocumentSnapshot user = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get();
                        await Fireservice().BookReq(
                          BookRequest(
                            bookId: widget.bookId,
                            bookName: widget.bookName,
                            adminAccept: 0,
                            url: widget.url,
                            userId: user['uid'],
                            userName: user['name'],
                            number: number.text,
                            daysYouNeed: todate.text,
                            createdAt: FieldValue.serverTimestamp(),
                            startdate: DateFormat(
                              'd/M/yyyy',
                            ).format(DateTime.now()),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white38),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.book, color: Colors.white60),
                            Text(
                              " Save",
                              style: TextStyle(color: Colors.white60),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget info(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),

            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

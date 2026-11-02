import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Requestuser extends StatefulWidget {
  const Requestuser({super.key});

  @override
  State<Requestuser> createState() => _RequestuserState();
}

class _RequestuserState extends State<Requestuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("bookrequest")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Requests", style: TextStyle(color: Colors.white)),
            );
          }

          final data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final book = data[index];
              final map = book.data() as Map<String, dynamic>;
              return Card(
                color: Colors.grey.shade900,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          map['url'] ?? "",
                          height: 120,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Are You Sure?"),
                                  content: const Text("Please Confirm"),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text("Yes"),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("bookrequest")
                                            .doc(book.id)
                                            .update({"adminAccept": 1});

                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: const Text("No"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "User Request",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Book: ${map['bookName'] ?? ''}",
                                style: const TextStyle(color: Colors.white70),
                              ),
                              Text(
                                "Days: ${map['daysYouNeed'] ?? ''}",
                                style: const TextStyle(color: Colors.white70),
                              ),
                              Text(
                                "Username: ${map['userName'] ?? ''}",
                                style: const TextStyle(color: Colors.white70),
                              ),
                              Text(
                                "Created At: ${map['startDate'] ?? ""}",
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                              map['adminAccept'] == 1
                                  ? Text(
                                      "Active",
                                      style: TextStyle(color: Colors.green),
                                    )
                                  : Text(
                                      "Reject ",
                                      style: TextStyle(color: Colors.red),
                                    ),
                            ],
                          ),
                        ),
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

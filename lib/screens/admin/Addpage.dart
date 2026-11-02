import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Bookmodel.dart';
import 'package:flutter_application_1/service/FireService.dart';

class Addpage extends StatefulWidget {
  const Addpage({super.key});

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  final name = TextEditingController();
  String? Categorycnt;
  final urll = TextEditingController();
  final author = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text(
          "Libro",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Manage Book Details",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Update the catalog with precise book information.",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Name
                  Text(
                    "BOOK NAME",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: name,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "AUTHOR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: author,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),

                  const SizedBox(height: 18),
                  Text(
                    "BOOK URL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: urll,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),

                  const SizedBox(height: 18),

                  // Category
                  Text(
                    "CATEGORY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        value: Categorycnt,
                        hint: Text(
                          "Select Category",
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: const Color(0xFF2A2A2A),
                        style: const TextStyle(color: Colors.white),
                        underline: SizedBox.shrink(),
                        isExpanded: true,

                        items: const [
                          DropdownMenuItem(
                            value: "Novel",
                            child: Text("Novel"),
                          ),
                          DropdownMenuItem(
                            value: "Science",
                            child: Text("Science"),
                          ),
                          DropdownMenuItem(
                            value: "History",
                            child: Text("History"),
                          ),
                          DropdownMenuItem(
                            value: "Biography",
                            child: Text("Biography"),
                          ),
                          DropdownMenuItem(
                            value: "Romance",
                            child: Text("Romance"),
                          ),
                          DropdownMenuItem(
                            value: "Mystery",
                            child: Text("Mystery"),
                          ),
                        ],
                        onChanged: (value) {
                          Categorycnt = value!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          final String generatedId = FirebaseFirestore.instance
                              .collection('books')
                              .doc()
                              .id;

                          await Fireservice().AddBook(
                            BookModel(
                              category: Categorycnt,
                              book: name.text,
                              author: author.text,
                              urll: urll.text,
                              bookId: generatedId,
                              userUid: '',
                              officeuid: FirebaseAuth.instance.currentUser!.uid,
                            ),
                          );
                          name.clear();
                          author.clear();
                          urll.clear();
                          Categorycnt = null;
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Save Book"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade700),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

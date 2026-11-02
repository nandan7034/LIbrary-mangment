import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_application_1/model/Adminmodel.dart';
import 'package:flutter_application_1/model/Bookmodel.dart';
import 'package:flutter_application_1/model/Usermodel.dart';
import 'package:flutter_application_1/model/bookrequest.dart';

class Fireservice {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> userdata(UserModel user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set(user.toJson());
  }
  // ad min base//

  Future<void> Admindata(Adminmodel admin) async {
    await FirebaseFirestore.instance
        .collection("admin")
        .doc(user!.uid)
        .set(admin.toJson());
  }

  //add Book//

  Future<void> AddBook(BookModel book) async {
    try {
      final bookRef = FirebaseFirestore.instance
          .collection('books')
          .doc(book.bookId);

      await bookRef.set(book.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> EditBook(BookModel book) async {
    try {
      await FirebaseFirestore.instance
          .collection("books")
          .doc(book.bookId)
          .update(book.Updatejson());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> BookReq(BookRequest request) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection("bookrequest")
          .doc(user!.uid)
          .set(request.toMap());
    } catch (e) {
      e.toString();
    }
  }

  
}

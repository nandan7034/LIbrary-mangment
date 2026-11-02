import 'package:cloud_firestore/cloud_firestore.dart';

class BookRequest {
  String? bookId;
  String? bookName;
  String? userId;
  String? number;
  int? adminAccept;
  String? userName;
  FieldValue? createdAt;
  String? daysYouNeed;
  String? url;
  String? startdate;

  BookRequest({
    this.bookId,
    this.bookName,
    this.userId,
    this.number,
    this.adminAccept,
    this.userName,
    this.createdAt,
    this.daysYouNeed,
    this.startdate,
    this.url,
  });

  factory BookRequest.fromMap(Map<String, dynamic> map) {
    return BookRequest(
      bookId: map['bookId'],
      bookName: map['bookName'],
      userId: map['userId'],
      number: map['number'],
      url: map['url'],
      adminAccept: map['adminAccept'],
      userName: map['userName'],
      daysYouNeed: map['daysYouNeed'],
      createdAt: null, // Firestore returns a Timestamp when reading.
      startdate: map['startDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'bookName': bookName,
      'userId': userId,
      'number': number,
      'url': url,
      'adminAccept': adminAccept,
      'userName': userName,
      'daysYouNeed': daysYouNeed,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'startDate': startdate,
    };
  }

  Map<String, dynamic> UpdateMap() {
    return {'adminAccept': adminAccept};
  }
}

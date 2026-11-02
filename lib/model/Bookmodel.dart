class BookModel {
  String? book;
  String? author;
  String? category;
  String? urll;
  String? bookId;
  String? officeuid;
  String? userUid;

  BookModel({
    this.book,
    this.author,
    this.category,
    this.urll,
    this.bookId,
    this.officeuid,
    this.userUid,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      book: json['book'],
      author: json['author'],
      category: json['category'],
      bookId: json['bookId'],
      officeuid: json['officeuid'],
      userUid: json['userUid'],

      urll: json['urll'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book': book,
      'author': author,
      'category': category,
      'bookId': bookId,
      'officeuid': officeuid,
      'userUid': userUid,
      'urll': urll,
    };
  }

  Map<String, dynamic> Updatejson() {
    return {
      'book': book,
      'author': author,
      'catagory': category,
      'bookId': bookId,
      'urll': urll,
    };
  }
}

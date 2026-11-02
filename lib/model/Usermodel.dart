class UserModel {
  String? name;
  String? email;
  String? password;
  String? uid;

  UserModel({this.name, this.email, this.password, this.uid});

  // Convert JSON to UserModel
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    uid = json['uid'];
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password, 'uid': uid};
  }
}

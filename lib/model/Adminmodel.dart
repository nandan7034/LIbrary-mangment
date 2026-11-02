class Adminmodel {
  String? name;
  String? email;
  String? password;
  String? uid;

  Adminmodel({this.name, this.email, this.password, this.uid});

  // Convert JSON to UserModel
 factory Adminmodel.fromJson(Map<String, dynamic> json) {
    return Adminmodel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      uid: json['uid'],
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password, 'uid': uid};
  }
}

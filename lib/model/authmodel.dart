class AuthModel {
  String? email;
  String? password;

  // Constructor with optional parameters
  AuthModel({this.email, this.password});

  // Factory constructor to create an instance from JSON
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

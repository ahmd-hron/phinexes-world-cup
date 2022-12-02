import 'dart:convert';

class User {
  String? email;
  String? password;
  String? token;
  DateTime? tokenDate;
  String? id;
  String? name;
  int? points;
  bool hasBetted = false;
  User({
    this.email,
    this.password,
    this.hasBetted = false,
    this.token,
    this.tokenDate,
    this.id,
    this.name,
    this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'token': token,
      'tokenDate': tokenDate!.toIso8601String(),
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  User fromShared(Map<String, dynamic> data) {
    return User(
      email: data['email'],
      password: data['password'],
      token: data['token'],
      tokenDate: DateTime.tryParse(data['tokenDate']),
      id: null,
      name: null,
      points: null,
    );
  }
}

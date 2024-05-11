import 'dart:convert';

class User {
  String? id;
  String name;
  String address;
  String contact;
  String username;

  User({
    this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.username,
  });

  // Factory constructor to instantiate object from json format
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      contact: json['contact'],
      username: json['username'],
    );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(User user) {
    return {
      'name': user.name,
      'address': user.address,
      'contact': user.contact,
      'username': user.username,
    };
  }
}

import 'dart:convert';

class Type {
  String? id;
  String username;
  String usertype;

  Type({
    this.id,
    required this.username,
    required this.usertype,
  });

  // Factory constructor to instantiate object from json format
  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
      username: json['username'],
      usertype: json['usertype'],
    );
  }

  static List<Type> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Type>((dynamic d) => Type.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Type type) {
    return {
      'username': type.username,
      'usertype': type.usertype,
    };
  }
}

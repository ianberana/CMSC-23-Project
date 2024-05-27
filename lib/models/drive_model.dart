import 'dart:convert';

class Drive {
  String? id;
  String name;
  String description;
  String contact;
  String email;
  String orgId;

  Drive({
    this.id,
    required this.name,
    required this.description,
    required this.contact,
    required this.email,
    required this.orgId,
  });

  // Factory constructor to instantiate object from json format
  factory Drive.fromJson(Map<String, dynamic> json) {
    return Drive(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      contact: json['contact'],
      email: json['email'],
      orgId: json['orgId'],
    );
  }

  static List<Drive> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Drive>((dynamic d) => Drive.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Drive drive) {
    return {
      'name': drive.name,
      'description': drive.description,
      'contact': drive.contact,
      'email': drive.email,
      'orgId': drive.orgId
    };
  }
}
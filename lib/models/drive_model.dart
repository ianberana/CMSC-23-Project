import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Drive {
  String? id;
  DateTime dateCreated;
  String name;
  String description;
  String contact;
  String email;
  String orgId;
  // DateTime date;

  Drive({
    this.id,
    required this.dateCreated,
    required this.name,
    required this.description,
    required this.contact,
    required this.email,
    required this.orgId,
    // required this.date,
  });

  // Factory constructor to instantiate object from json format
  factory Drive.fromJson(Map<String, dynamic> json) {
    return Drive(
      id: json['id'],
      dateCreated: (json['dateCreated'] as Timestamp?)?.toDate() ?? DateTime.now(),
      name: json['name'],
      description: json['description'],
      contact: json['contact'],
      email: json['email'],
      orgId: json['orgId'],
      // date: (json['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  static List<Drive> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Drive>((dynamic d) => Drive.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Drive drive) {
    return {
      'dateCreated': drive.dateCreated,
      'name': drive.name,
      'description': drive.description,
      'contact': drive.contact,
      'email': drive.email,
      'orgId': drive.orgId,
      // 'date': Timestamp.fromDate(date),
    };
  }
}

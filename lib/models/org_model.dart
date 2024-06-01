import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Organization {
  String? id;
  DateTime dateCreated;
  String name;
  String? description;
  String address;
  String contact;
  String email;
  String? proof;
  bool approved;
  bool status;

  Organization({
    this.id,
    required this.dateCreated,
    required this.name,
    this.description,
    required this.address,
    required this.contact,
    required this.email,
    this.proof,
    this.approved = false,
    required this.status,
  });

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      dateCreated: (json['dateCreated'] as Timestamp).toDate(),
      name: json['name'],
      description: json['description'],
      address: json['address'],
      contact: json['contact'],
      email: json['email'],
      proof: json['proof'],
      approved: json['approved'],
      status: json['status'],
    );
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<Organization>((dynamic d) => Organization.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(Organization org) {
    return {
      'dateCreated': org.dateCreated,
      'name': org.name,
      'description': org.description,
      'address': org.address,
      'contact': org.contact,
      'email': org.email,
      'proof': org.proof,
      'approved': org.approved,
      'status': org.status
    };
  }
}

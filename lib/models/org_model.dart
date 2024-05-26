import 'dart:convert';
import 'package:file_picker/file_picker.dart';

class Organization {
  String? id;
  String name;
  String address;
  String contact;
  String email;
  String? proof;
  bool approved;

  Organization({
    this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.email,
    this.proof,
    this.approved = false,
  });

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      contact: json['contact'],
      email: json['email'],
      proof: json['proof'],
      approved: json['approved'],
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
      'name': org.name,
      'address': org.address,
      'contact': org.contact,
      'email': org.email,
      'proof': org.proof,
      'approved': org.approved
    };
  }
}

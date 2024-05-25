import 'dart:convert';

class Organization {
  String? id;
  String name;
  String address;
  String contact;
  String email;

  Organization({
    this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.email,
  });

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      contact: json['contact'],
      email: json['email'],
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
    };
  }
}

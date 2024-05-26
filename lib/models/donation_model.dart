import 'dart:convert';
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';

class Donation {
  String? id;
  String item;
  String delivery;
  double weight;
  File? photo;
  DateTime date;
  List address;
  String status;
  QrImage? qr;
  String donorId;
  String? driveId;

  Donation({
    this.id,
    required this.item,
    required this.delivery,
    required this.weight,
    this.photo,
    required this.date,
    required this.address,
    required this.status,
    this.qr,
    required this.donorId,
    this.driveId,
  });

  // Factory constructor to instantiate object from json format
  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      item: json['item'],
      delivery: json['delivery'],
      weight: json['weight'],
      photo: json['photo'],
      date: json['date'],
      address: json['address'],
      status: json['status'],
      qr: json['qr'],
      donorId: json['donorId'],
      driveId: json['driveId'],
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'item': donation.item,
      'delivery': donation.delivery,
      'weight': donation.weight,
      'photo': donation.photo,
      'date': donation.date,
      'address': donation.address,
      'status': donation.status,
      'qr': donation.qr,
      'donorId': donation.donorId,
    };
  }
}

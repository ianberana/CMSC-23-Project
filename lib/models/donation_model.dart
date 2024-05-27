import 'dart:convert';
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';

class Donation {
  String? id;
  String item;
  String delivery;
  double weight;
  String? photo;
  DateTime date;
  List address;
  String? contact;
  String status;
  QrImage? qr;
  String donorId;
  String? driveId;
  String? drivePhoto;

  Donation({
    this.id,
    required this.item,
    required this.delivery,
    required this.weight,
    this.photo,
    required this.date,
    required this.address,
    this.contact,
    this.status = "pending",
    this.qr,
    required this.donorId,
    this.driveId,
    this.drivePhoto,
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
        drivePhoto: json['drivePhoto']);
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
      'driveId': donation.driveId,
      'drivePhoto': donation.drivePhoto
    };
  }
}

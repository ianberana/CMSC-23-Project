import 'dart:convert';
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';

class Donation {
  String? id;
  DateTime dateCreated;
  String item;
  String delivery;
  double weight;
  String? photo;
  DateTime dateDelivery;
  List address;
  String? contact;
  String status;
  QrImage? qr;
  String donorId;
  String? driveId;
  String? drivePhoto;

  Donation({
    this.id,
    required this.dateCreated,
    required this.item,
    required this.delivery,
    required this.weight,
    this.photo,
    required this.dateDelivery,
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
        dateCreated: json['dateCreated'],
        item: json['item'],
        delivery: json['delivery'],
        weight: json['weight'],
        photo: json['photo'],
        dateDelivery: json['dateDelivery'],
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
      'dateCreated': donation.dateCreated,
      'item': donation.item,
      'delivery': donation.delivery,
      'weight': donation.weight,
      'photo': donation.photo,
      'dateDelivery': donation.dateDelivery,
      'address': donation.address,
      'status': donation.status,
      'qr': donation.qr,
      'donorId': donation.donorId,
      'driveId': donation.driveId,
      'drivePhoto': donation.drivePhoto
    };
  }
}

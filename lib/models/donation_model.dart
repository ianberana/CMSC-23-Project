import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Donation {
  String? id;
  DateTime dateCreated;
  List<String> item;
  String delivery;
  double weight;
  String? photo;
  DateTime dateDelivery;
  List address;
  String contact;
  String status;
  QrImage? qr;
  String donorId;
  String orgId;
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
    required this.contact,
    this.status = "pending",
    this.qr,
    required this.donorId,
    required this.orgId,
    this.driveId = "",
    this.drivePhoto = "",
  });

  // Factory constructor to instantiate object from json format
  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
        id: json['id'],
        dateCreated: (json['dateCreated'] as Timestamp).toDate(),
        item: List<String>.from(json['item']),
        delivery: json['delivery'],
        weight: json['weight'],
        photo: json['photo'],
        dateDelivery: (json['dateDelivery'] as Timestamp).toDate(),
        address: List<String>.from(json['address']),
        contact: json['contact'],
        status: json['status'],
        qr: json['qr'],
        donorId: json['donorId'],
        orgId: json['orgId'],
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
      'contact': donation.contact,
      'status': donation.status,
      'qr': donation.qr,
      'donorId': donation.donorId,
      'orgId': donation.orgId,
      'driveId': donation.driveId,
      'drivePhoto': donation.drivePhoto,
      'driveId': donation.driveId,
      'drivePhoto': donation.drivePhoto
    };
  }
}
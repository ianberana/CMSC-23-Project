import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  Future<String> addDonation(Map<String, dynamic> donation, File photo) async {
    try {
      final donationRef = await db.collection("donations").add(donation);
      await db
          .collection("donations")
          .doc(donationRef.id)
          .update({'id': donationRef.id});

      final photoRef = await storage.ref().child("donation/${donationRef.id}");

      UploadTask upload = photoRef.putFile(photo);
      final snapshot = await upload.whenComplete(() {});

      String url = await snapshot.ref.getDownloadURL();
      await db
          .collection("donations")
          .doc(donationRef.id)
          .update({'photo': url});

      return "Successfully added donation!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateStatus(String id, String status) async {
    try {
      await db.collection("donations").doc(id).update({"status": status});

      return "Successfully updated status!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> linkDrive(String id, String driveId, File photo) async {
    try {
      await db.collection("donations").doc(id).update({"driveId": driveId});

      final photoRef = await storage.ref().child("drive/${id}");

      UploadTask upload = photoRef.putFile(photo);
      final snapshot = await upload.whenComplete(() {});

      String url = await snapshot.ref.getDownloadURL();
      await db.collection("donations").doc(id).update({'drivePhoto': url});

      return "Successfully linked donation to donation drive!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}

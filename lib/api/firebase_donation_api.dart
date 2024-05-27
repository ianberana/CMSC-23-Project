import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  Future<String> addDonation(Map<String, dynamic> donation) async {
    try {
      final docRef = await db.collection("donations").add(donation);
      await db.collection("donations").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added donation!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> uploadPhoto(File photo, String id) async {
    try {
      // final file = File(photo.path);
      final docRef = await storage.ref().child("donation/${id}");

      UploadTask upload = docRef.putFile(photo);
      final snapshot = await upload.whenComplete(() {});

      String url = await snapshot.ref.getDownloadURL();
      return url;
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

  Future<String> updateDrive(String id, String driveId) async {
    try {
      await db.collection("donations").doc(id).update({"driveId": driveId});

      return "Successfully linked donation drive!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  // Stream<QuerySnapshot> getAllDonations() {
  //   return db.collection("donations").snapshots();
  // }

  // FOR DONORS
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

  Stream<QuerySnapshot> getDonorDonations(String donorId) {
    return db
        .collection("donations")
        .where("driveId", isEqualTo: donorId)
        .snapshots();
  }

  Future<String> cancelDonation(String id) async {
    QuerySnapshot donations = await db
        .collection("donations")
        .where("id", isEqualTo: id)
        .limit(1)
        .get();
    if (donations.docs.isNotEmpty) {
      DocumentSnapshot donationRef = donations.docs.first;
      final donation = donationRef.data() as Map<String, dynamic>;

      if (donation['status'] == "pending") {
        try {
          await db
              .collection("donations")
              .doc(id)
              .update({"status": "canceled"});
          return "Successfully canceled donation.";
        } on FirebaseException catch (e) {
          return "Failed with error '${e.code}: ${e.message}";
        }
      } else
        return "Cannot cancel ${donation['status']} donation!";
    } else {
      return "Donation not found!";
    }
  }

  // FOR ORGANIZATION
  Future<String> confirmDonation(String id, bool status) async {
    QuerySnapshot donations = await db
        .collection("donations")
        .where("id", isEqualTo: id)
        .limit(1)
        .get();
    if (donations.docs.isNotEmpty) {
      DocumentSnapshot donationRef = donations.docs.first;
      final donation = donationRef.data() as Map<String, dynamic>;

      if (donation['status'] == "pending") {
        try {
          await db.collection("donations").doc(id).update({"status": status});
          return "Successfully ${status} donation.";
        } on FirebaseException catch (e) {
          return "Failed with error '${e.code}: ${e.message}";
        }
      } else
        return "Cannot ${status} ${donation['status']} donation!";
    } else {
      return "Donation not found!";
    }
  }

  Future<String> completeDonation(String id, String driveId, File photo) async {
    QuerySnapshot donations = await db
        .collection("donations")
        .where("id", isEqualTo: id)
        .limit(1)
        .get();
    if (donations.docs.isNotEmpty) {
      DocumentSnapshot donationRef = donations.docs.first;
      final donation = donationRef.data() as Map<String, dynamic>;

      if (donation['status'] == "confirmed" ||
          donation['status'] == "scheduled") {
        try {
          await db
              .collection("donations")
              .doc(id)
              .update({"status": "complete", "driveId": driveId});

          final photoRef = await storage.ref().child("drive/${id}");

          UploadTask upload = photoRef.putFile(photo);
          final snapshot = await upload.whenComplete(() {});

          String url = await snapshot.ref.getDownloadURL();
          await db.collection("donations").doc(id).update({'drivePhoto': url});

          return "Successfully linked donation to donation drive.";
        } on FirebaseException catch (e) {
          return "Failed with error '${e.code}: ${e.message}";
        }
      } else
        return "Cannot complete ${donation['status']} donation!";
    } else {
      return "Donation not found!";
    }
  }

  // FOR ORGANIZATION ADMIN
  Stream<QuerySnapshot> getOrgDonations(String orgId) {
    return db
        .collection("donations")
        .where("orgId", isEqualTo: orgId)
        .snapshots();
  }
}

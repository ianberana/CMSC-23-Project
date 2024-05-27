import 'dart:io';
import 'package:flutter/material.dart';
import '../api/firebase_donation_api.dart';
import '../models/donation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationListProvider with ChangeNotifier {
  late FirebaseDonationAPI firebaseService;
  late Stream<QuerySnapshot> donationStream;
  // Donation? currentDonation;

  DonationListProvider() {
    firebaseService = FirebaseDonationAPI();
    fetchDonations();
  }

  // getter
  Stream<QuerySnapshot> get getDonation => donationStream;
  // Donation get current => currentDonation!;

  // changeCurrentUser(Donation donation) {
  //   currentDonation = donation;
  // }

  void fetchDonations() {
    donationStream = firebaseService.getAllDonations();
    notifyListeners();
  }

  Future<void> addDonation(Donation donation) async {
    String message =
        await firebaseService.addDonation(donation.toJson(donation));
    print(message);
    notifyListeners();
  }

  Future<String> uploadPhoto(File proof, String id) async {
    String url = await firebaseService.uploadPhoto(proof, id);
    notifyListeners();
    return url;
  }

  Future<void> updateStatus(String id, String status) async {
    String message = await firebaseService.updateStatus(id, status);
    print(message);
    notifyListeners();
  }

  Future<void> updateDrive(String id, String driveId) async {
    String message = await firebaseService.updateDrive(id, driveId);
    print(message);
    notifyListeners();
  }
}

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

  Future<void> addDonation(Donation donation, File photo) async {
    String message =
        await firebaseService.addDonation(donation.toJson(donation), photo);
    print(message);
    notifyListeners();
  }

  Future<void> updateStatus(String id, String status) async {
    String message = await firebaseService.updateStatus(id, status);
    print(message);
    notifyListeners();
  }

  Future<void> linkDrive(String id, String driveId, File photo) async {
    String message = await firebaseService.linkDrive(id, driveId, photo);
    print(message);
    notifyListeners();
  }
}

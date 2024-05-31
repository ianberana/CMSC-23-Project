import 'dart:io';
import 'package:flutter/material.dart';
import '../api/firebase_donation_api.dart';
import '../models/donation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationListProvider with ChangeNotifier {
  late FirebaseDonationAPI firebaseService;

  DonationListProvider() {
    firebaseService = FirebaseDonationAPI();
  }

  // FOR DONOR
  Future<void> addDonation(Donation donation) async {
    String message =
        await firebaseService.addDonation(donation.toJson(donation));
    print(message);
    notifyListeners();
  }

  Stream<QuerySnapshot> getDonorDonations(String donorId) {
    Stream<QuerySnapshot> donationStream =
        firebaseService.getDonorDonations(donorId);
    notifyListeners();
    return donationStream;
  }

  Future<void> cancelDonation(String id) async {
    String message = await firebaseService.cancelDonation(id);
    print(message);
    notifyListeners();
  }

  // FOR ORGANIZATION
  Future<void> confirmDonation(String id, bool status) async {
    String message = await firebaseService.confirmDonation(id, status);
    print(message);
    notifyListeners();
  }

  Future<void> completeDonation(String id, String driveId, File photo) async {
    String message = await firebaseService.completeDonation(id, driveId, photo);
    print(message);
    notifyListeners();
  }

  // FOR ORGANIZATION/ADMIN
  Stream<QuerySnapshot> getOrgDonations(String orgId) {
    Stream<QuerySnapshot> donationStream =
        firebaseService.getOrgDonations(orgId);
    return donationStream;
  }
}
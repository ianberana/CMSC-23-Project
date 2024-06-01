import 'dart:io';
import 'package:elbi_donate/models/donor_model.dart';
import 'package:elbi_donate/models/drive_model.dart';
import 'package:flutter/material.dart';
import '../api/firebase_donation_api.dart';
import '../models/donation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationListProvider with ChangeNotifier {
  late FirebaseDonationAPI firebaseService;
  late Stream<QuerySnapshot> donationStream;
  Donation? _donation;
  Donor? _donor;

  Stream<QuerySnapshot> get getAllDonations => donationStream;
  Donation? get donation => _donation;
  Donor? get donor => _donor;

  DonationListProvider() {
    firebaseService = FirebaseDonationAPI();
    setAllDonations();
  }

  // FOR DONOR
  Future<String> addDonation(Donation donation, File photo) async {
    String id =
        await firebaseService.addDonation(donation.toJson(donation), photo);
    notifyListeners();
    return id;
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
  Future<void> confirmDonation(String id, String status) async {
    String message = await firebaseService.confirmDonation(id, status);
    print(message);
    notifyListeners();
  }

  // Future<void> completeDonation(String id, String driveId, File photo) async {
  //   String message = await firebaseService.completeDonation(id, driveId, photo);
  //   print(message);
  //   notifyListeners();
  // }

  Future<void> completeDonation(String id, String driveId) async {
    String message = await firebaseService.completeDonation(id, driveId);
    print(message);
    notifyListeners();
  }

  Future<void> fetchDonationDetails(String donationId) async {
    DocumentSnapshot donationSnapshot =
        await firebaseService.fetchDonationDetails(donationId);
    _donation =
        Donation.fromJson(donationSnapshot.data() as Map<String, dynamic>);
    notifyListeners();
  }

  // Method to fetch donor details by donorId
  Future<void> fetchDonorDetails(String donorId) async {
    DocumentSnapshot donorSnapshot =
        await firebaseService.getDonorById(donorId);
    _donor = Donor.fromJson(donorSnapshot.data() as Map<String, dynamic>);
    notifyListeners();
  }

  // Method to fetch donor details by donorId
  Future<Donor> getDonorDetails(String donorId) async {
    DocumentSnapshot donorSnapshot =
        await firebaseService.getDonorById(donorId);
    return Donor.fromJson(donorSnapshot.data() as Map<String, dynamic>);
  }

  Stream<QuerySnapshot> getDriveDonations(String driveId) {
    Stream<QuerySnapshot> donationStream =
        firebaseService.getDriveDonations(driveId);
    return donationStream;
  }

  // FOR ORGANIZATION
  Stream<QuerySnapshot> getOrgDonations(String orgId) {
    Stream<QuerySnapshot> donationStream =
        firebaseService.getOrgDonations(orgId);
    return donationStream;
  }

  //ADMIN
  void setAllDonations() {
    donationStream = firebaseService.getAllDonations();
  }
}

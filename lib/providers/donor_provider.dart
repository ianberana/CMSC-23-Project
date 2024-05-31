import 'package:flutter/material.dart';
import '../api/firebase_donor_api.dart';
import '../models/donor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorListProvider with ChangeNotifier {
  late FirebaseDonorAPI firebaseService;
  late Stream<QuerySnapshot> donorStream; // FOR ADMIN
  Donor? donor; // FOR DONOR

  DonorListProvider() {
    firebaseService = FirebaseDonorAPI();
    setAllDonors(); // FOR ADMIN
  }

  // getter
  Stream<QuerySnapshot> get getAllDonors => donorStream; // FOR ADMIN
  Donor? get currentDonor => donor; // FOR DONOR

  // FOR SIGNUP/AUTHENTICATION
  Future<String> addDonor(Donor donor) async {
    String id = await firebaseService.addDonor(donor.toJson(donor));
    notifyListeners();
    return id;
  }

  // FOR DONOR
  Future<void> setCurrentDonor(String donorId) async {
    donor = Donor.fromJson(await firebaseService.getCurrentDonor(donorId));
    notifyListeners();
  }

  // FOR ADMIN
  void setAllDonors() {
    donorStream = firebaseService.getAllDonors();
    notifyListeners();
  }
}

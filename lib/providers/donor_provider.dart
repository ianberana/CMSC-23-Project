import 'package:flutter/material.dart';
import '../api/firebase_donor_api.dart';
import '../models/donor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorListProvider with ChangeNotifier {
  late FirebaseDonorAPI firebaseService;
  late Stream<QuerySnapshot> donorStream;
  Donor? currentDonor;

  DonorListProvider() {
    firebaseService = FirebaseDonorAPI();
    fetchDonors();
  }

  // getter
  Stream<QuerySnapshot> get getDonor => donorStream;
  Donor get current => currentDonor!;

  changeCurrentUser(Donor donor) {
    currentDonor = donor;
  }

  void fetchDonors() {
    donorStream = firebaseService.getAllDonors();
    notifyListeners();
  }

  Future<void> addDonor(Donor donor) async {
    String message = await firebaseService.addDonor(donor.toJson(donor));
    print(message);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import '../api/firebase_drive_api.dart';
import '../models/drive_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriveListProvider with ChangeNotifier {
  late FirebaseDriveAPI firebaseService;
  late Stream<QuerySnapshot> driveStream;
  // Donor? currentDonor;

  DriveListProvider() {
    firebaseService = FirebaseDriveAPI();
    fetchDrives();
  }

  // getter
  Stream<QuerySnapshot> get getDonor => driveStream;
  // Donor get current => currentDonor!;

  // changeCurrentUser(Donor donor) {
  //   currentDonor = donor;
  // }

  void fetchDrives() {
    driveStream = firebaseService.getAllDrives();
    notifyListeners();
  }

  Future<void> addDrive(Drive drive) async {
    String message = await firebaseService.addDrive(drive.toJson(drive));
    print(message);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import '../api/firebase_drive_api.dart';
import '../models/drive_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriveListProvider with ChangeNotifier {
  late FirebaseDriveAPI firebaseService;
  DriveListProvider() {
    firebaseService = FirebaseDriveAPI();
  }

  // FOR DONOR/ORGANIZATION
  Stream<QuerySnapshot> getOrgDrives(String orgId) {
    Stream<QuerySnapshot> driveStream = firebaseService.getOrgDrives(orgId);
    notifyListeners();
    return driveStream;
  }

  // FOR ORGANIZATION
  Future<void> addDrive(Drive drive) async {
    String message = await firebaseService.addDrive(drive.toJson(drive));
    print(message);
    notifyListeners();
  }

  Future<void> editDrive(Drive drive, String id) async {
    String message = await firebaseService.editDrive(drive, id);
    print(message);
    notifyListeners();
  }

  Future<void> deleteDrive(String id) async {
    String message = await firebaseService.deleteDrive(id);
    print(message);
    notifyListeners();
  }
}

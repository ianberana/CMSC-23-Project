import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../api/firebase_org_api.dart';
import '../models/org_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrgListProvider with ChangeNotifier {
  late FirebaseOrgAPI firebaseService;
  late Stream<QuerySnapshot> orgStream; // FOR DONORS/ADMIN
  Organization? org; // FOR ORGANIZATION

  OrgListProvider() {
    firebaseService = FirebaseOrgAPI();
    setAllOrganizations(); // FOR DONORS
  }

  // getter
  Stream<QuerySnapshot> get getAllOrganizations =>
      orgStream; // FOR DONORS/ADMIN
  Organization? get currentOrg => org; // FOR ORGANIZATION

  // FOR SIGNUP/AUTHENTICATION
  Future<String> addOrganization(Organization org, PlatformFile proof) async {
    String id = await firebaseService.addOrganization(org.toJson(org), proof);
    notifyListeners();
    return id;
  }

  // FOR ORGANIZATION
  Future<void> setCurrentOrg(String orgId) async {
    org = Organization.fromJson(await firebaseService.getCurrentOrg(orgId));
    notifyListeners();
  }

  Future<void> updateStatus(bool status) async {
    if (org!.status && status)
      print("Organization is already open.");
    else if (!(org!.status) && !status)
      print("Organization is already closed.");

    String message = await firebaseService.updateStatus(org!.id!, status);
    print(message);
    notifyListeners();
  }

  // FOR DONORS/ADMIN
  void setAllOrganizations() {
    orgStream = firebaseService.getAllOrganizations();
    notifyListeners();
  }

  // FOR ADMIN
  Future<void> approveOrganization(String id) async {
    String message = await firebaseService.approveOrganization(id);
    print(message);
    notifyListeners();
  }
}

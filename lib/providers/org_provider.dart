import 'package:flutter/material.dart';
import '../api/firebase_org_api.dart';
import '../models/org_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrgListProvider with ChangeNotifier {
  late FirebaseOrgAPI firebaseService;
  late Stream<QuerySnapshot> orgStream;
  Organization? currentOrg;

  OrgListProvider() {
    firebaseService = FirebaseOrgAPI();
    fetchOrganizations();
  }

  // getter
  Stream<QuerySnapshot> get getOrganizations => orgStream;
  Organization get current => currentOrg!;

  changeCurrentOrganization(Organization org) {
    currentOrg = org;
  }

  void fetchOrganizations() {
    orgStream = firebaseService.getAllOrganizations();
    notifyListeners();
  }

  Future<String> addOrganization(Organization org) async {
    String message = await firebaseService.addOrganization(org.toJson(org));
    notifyListeners();
    return message;
  }

  Future<void> addProof(String id, String url) async {
    String message = await firebaseService.addProof(id, url);
    print(message);
    notifyListeners();
  }
}

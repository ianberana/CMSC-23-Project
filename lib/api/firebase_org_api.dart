import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  // FOR SIGNUP/AUTHENTICATION
  Future<String> addOrganization(
      Map<String, dynamic> org, PlatformFile proof) async {
    try {
      final orgRef = await db.collection("orgs").add(org);
      await db.collection("orgs").doc(orgRef.id).update({'id': orgRef.id});

      final file = File(proof.path!);
      final proofRef = await storage.ref().child("organization/${orgRef.id}");

      UploadTask upload = proofRef.putFile(file);
      final snapshot = await upload.whenComplete(() {});

      String url = await snapshot.ref.getDownloadURL();
      await db.collection("orgs").doc(orgRef.id).update({'proof': url});

      return orgRef.id;
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  // FOR ORGANIZATION
  Future<Map<String, dynamic>> getCurrentOrg(String orgId) async {
    QuerySnapshot orgs =
        await db.collection("orgs").where("id", isEqualTo: orgId).get();

    if (orgs.docs.isNotEmpty) {
      DocumentSnapshot orgRef = orgs.docs.first;
      // Convert the document into a MyModel object
      final org = orgRef.data() as Map<String, dynamic>;
      // print(org);
      return org;
    } else {
      return {};
    }
  }

  Future<String> updateStatus(String id, bool status) async {
    try {
      await db.collection("orgs").doc(id).update({"status": status});

      if (status)
        return "Organization is now open for donations!";
      else
        return "Organization is now currently not accepting donations!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  // FOR DONORS/ADMIN
  Stream<QuerySnapshot> getAllOrganizations() {
    return db.collection("orgs").snapshots();
  }

  // FOR ADMIN
  Future<String> approveOrganization(String id) async {
    try {
      await db.collection("orgs").doc(id).update({"approved": true});

      return "Successfully approved organization!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}

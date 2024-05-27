import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getAllOrganizations() {
    return db.collection("orgs").snapshots();
  }

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

      return "Successfully added organization";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateStatus(String id, bool status) async {
    try {
      await db.collection("orgs").doc(id).update({"status": status});

      return "Successfully updated status!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}

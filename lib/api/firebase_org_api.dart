import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addOrganization(Map<String, dynamic> org) async {
    try {
      final docRef = await db.collection("orgs").add(org);
      await db.collection("orgs").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added organization!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllOrganizations() {
    return db.collection("orgs").snapshots();
  }
}

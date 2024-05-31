import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/drive_model.dart';

class FirebaseDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // FOR DONOR/ORGANIZATION
  Stream<QuerySnapshot> getOrgDrives(String orgId) {
    return db.collection("drives").where("orgId", isEqualTo: orgId).snapshots();
  }

  // FOR ORGANIZATION
  Future<String> addDrive(Map<String, dynamic> drive) async {
    try {
      final docRef = await db.collection("drives").add(drive);
      await db.collection("drives").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added donation drive!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> editDrive(Drive drive, String id) async {
    try {
      await db.collection("drives").doc(id).update({
        "name": drive.name,
        "description": drive.description,
        "contact": drive.contact,
        "email": drive.email
      });

      return "Successfully updated donation drive!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> deleteDrive(String id) async {
    try {
      await db.collection("drives").doc(id).delete();

      return "Successfully deleted donation drive!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDrive(Map<String, dynamic> drive) async {
    try {
      final docRef = await db.collection("drives").add(drive);
      await db.collection("drives").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added donation drive!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDrives() {
    return db.collection("drives").snapshots();
  }
}

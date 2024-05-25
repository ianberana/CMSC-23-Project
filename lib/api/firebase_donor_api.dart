import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonor(Map<String, dynamic> donor) async {
    try {
      final docRef = await db.collection("donors").add(donor);
      await db.collection("donors").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonors() {
    return db.collection("donors").snapshots();
  }
}

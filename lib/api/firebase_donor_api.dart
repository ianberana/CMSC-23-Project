import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // FOR SIGNUP/AUTHENTICATION
  Future<String> addDonor(Map<String, dynamic> donor) async {
    try {
      final docRef = await db.collection("donors").add(donor);
      await db.collection("donors").doc(docRef.id).update({'id': docRef.id});

      return docRef.id;
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  // FOR DONOR
  Future<Map<String, dynamic>> getCurrentDonor(String donorId) async {
    QuerySnapshot donors = await db
        .collection("donors")
        .where("id", isEqualTo: donorId)
        .limit(1)
        .get();
    if (donors.docs.isNotEmpty) {
      DocumentSnapshot donorRef = donors.docs.first;
      return donorRef.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  // FOR ADMIN
  Stream<QuerySnapshot> getAllDonors() {
    return db.collection("donors").snapshots();
  }
}

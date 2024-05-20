import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTypeAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addUserType(Map<String, dynamic> user) async {
    try {
      final docRef = await db.collection("types").add(user);
      await db.collection("types").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added organization!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllUserTypes() {
    return db.collection("types").snapshots();
  }
}

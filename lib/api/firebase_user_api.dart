import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("users").snapshots();
  }

  Future<String> addUser(Map<String, dynamic> user) async {
    try {
      final docRef = await db.collection("users").add(user);
      await db.collection("users").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added organization!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}

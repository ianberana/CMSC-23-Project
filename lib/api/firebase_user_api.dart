import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("users").snapshots();
  }

  Stream<QuerySnapshot> getUser(String email) {
    return db.collection("users").where("email", isEqualTo: email).snapshots();
  }

  Future<String> addUser(Map<String, dynamic> user) async {
    try {
      final docRef = await db.collection("users").add(user);

      return "Successfully added user!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}

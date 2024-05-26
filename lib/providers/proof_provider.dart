import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../api/firebase_proof_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProofProvider with ChangeNotifier {
  late FirebaseProofAPI firebaseService;
  // late Stream<QuerySnapshot> userStream;

  ProofProvider() {
    firebaseService = FirebaseProofAPI();
    // fetchUsers();
  }

  // getter
  // Stream<QuerySnapshot> get getUserTypes => userStream;

  // void fetchUsers() {
  //   userStream = firebaseService.getAllUsers();
  //   notifyListeners();
  // }

  Future<String> uploadProof(PlatformFile proof, String id) async {
    String message = await firebaseService.uploadProof(proof, id);
    notifyListeners();
    return message;
  }
}

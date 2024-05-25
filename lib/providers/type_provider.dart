import 'package:flutter/material.dart';
import '../api/firebase_type_api.dart';
import '../models/type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserTypeProvider with ChangeNotifier {
  late FirebaseTypeAPI firebaseService;
  late Stream<QuerySnapshot> typeStream;

  UserTypeProvider() {
    firebaseService = FirebaseTypeAPI();
    fetchUserTypes();
  }

  // getter
  Stream<QuerySnapshot> get getUserTypes => typeStream;

  void fetchUserTypes() {
    typeStream = firebaseService.getAllUserTypes();
    notifyListeners();
  }

  Future<void> addUserType(Type type) async {
    String message = await firebaseService.addUserType(type.toJson(type));
    print(message);
    notifyListeners();
  }
}

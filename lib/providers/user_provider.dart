import 'package:flutter/material.dart';
import '../api/firebase_user_api.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  late FirebaseUserAPI firebaseService;
  late Stream<QuerySnapshot> userStream;
  String? usertype;

  UserProvider() {
    firebaseService = FirebaseUserAPI();
    fetchUsers();
  }

  // getter
  Stream<QuerySnapshot> get getUserTypes => userStream;
  Stream<QuerySnapshot> getUser(String email) {
    return firebaseService.getUser(email);
  }

  void fetchUsers() {
    userStream = firebaseService.getAllUsers();
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    String message = await firebaseService.addUser(user.toJson(user));
    print(message);
    notifyListeners();
  }
}

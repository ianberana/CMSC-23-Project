import 'package:flutter/material.dart';
import '../api/firebase_user_api.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListProvider with ChangeNotifier {
  late FirebaseTodoAPI firebaseService;
  late Stream<QuerySnapshot> userStream;
  User? currentUser;

  UserListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchUsers();
  }

  // getter
  Stream<QuerySnapshot> get getUser => userStream;
  User get current => currentUser!;

  changeCurrentUser(User user) {
    currentUser = user;
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

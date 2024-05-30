import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> authStream;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get getAuthStream => authStream;
  User? get user => authService.userSignedIn();

  void fetchAuthentication() {
    authStream = authService.getUser();
    notifyListeners();
  }

  Future<String> signUp(String email, String password) async {
    String message = await authService.signUp(email, password);
    notifyListeners();

    return message;
  }

  Future<bool> signIn(String email, String password) async {
    bool error = await authService.signIn(email, password);
    notifyListeners();

    return error;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}

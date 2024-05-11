import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;
  User? get user => authService.userSignedIn();

  void fetchAuthentication() {
    uStream = authService.getUser();
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    await authService.signUp(email, password);
    notifyListeners();
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

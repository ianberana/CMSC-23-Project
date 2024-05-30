import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  User? userSignedIn() {
    return auth.currentUser;
  }

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  Future<bool> signIn(String username, String password) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: username, password: password);

      //let's print the object returned by signInWithEmailAndPassword
      //you can use this object to get the user's id, email, etc.
      print(credential);

      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //possible to return something more useful
        //than just print an error message to improve UI/UX
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return true;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //let's print the object returned by signInWithEmailAndPassword
      //you can use this object to get the user's id, email, etc.\
      print(credential);
      return "Successfully signed up new user.";
    } on FirebaseAuthException catch (e) {
      //possible to return something more useful
      //than just print an error message to improve UI/UX
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
      return "Failed to sign up new user.";
    }

    return "";
  }

  Future<void> signOut() async {
    auth.signOut();
  }
}

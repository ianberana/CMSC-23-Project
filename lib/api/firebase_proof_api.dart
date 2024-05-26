import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseProofAPI {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadProof(PlatformFile proof, String id) async {
    try {
      final file = File(proof.path!);
      final docRef = await storage.ref().child("organization/${id}");

      UploadTask upload = docRef.putFile(file);
      final snapshot = await upload.whenComplete(() {});

      String url = await snapshot.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}

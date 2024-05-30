import 'dart:io';

import 'package:elbi_donate/models/donation_model.dart';
import 'package:flutter/material.dart';
//import 'package:your_project/models/donation_model.dart';

class DonationListProvider with ChangeNotifier {
  List<Donation> _donations = [];

  List<Donation> get donations => _donations;

  Future<void> addDonation(Donation donation, File photo) async {
    // Implement your logic to add the donation, e.g., upload photo and save donation details to a database
    _donations.add(donation);
    notifyListeners();
  }
}

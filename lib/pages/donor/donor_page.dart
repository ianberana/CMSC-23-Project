import 'package:elbi_donate/providers/auth_provider.dart';
import 'package:elbi_donate/providers/donation_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'package:intl/intl_standalone.dart';
//import '../../providers/auth_provider.dart';
import '../../models/donation_model.dart';
import 'donor_drawer.dart';

class DonorPage extends StatefulWidget {
  const DonorPage({Key? key}) : super(key: key);

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  File? photo;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  User? user;

  final deliveryController = TextEditingController();
  final weightController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    return Scaffold(
      drawer: DonorDrawer(),
      appBar: AppBar(
        title: const Text("Donors Page"),
        backgroundColor: Color(0xFF008080),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Red Cross Youth of UPLB"),
            subtitle: Text(
                "The Red Cross Youth of University of the Philippines Los Banos is a non profit, mass based, student civic organization that aims to uphold humanity as one of its principles."),
            onTap: () {
              _showDonateDialog(context);
            },
          ),
          ListTile(
            title: Text("Umalohokan, Inc."),
            subtitle: Text(
                "Umalohokan, Inc. is a socio-cultural organization founded on December 21, 1977 in the University of the Philippines-Los Baños, at the height of the 1972 Martial Law."),
            onTap: () {
              _showDonateDialog(context);
            },
          ),
          // Add more ListTile widgets for additional organizations
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add static donation
          File? photo = await pickImageFromGallery();
          setState(() {
            this.photo = photo;
          });
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Future<File?> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    } else {
      return File(image.path);
    }
  }

  Future<File?> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    } else {
      return File(image.path);
    }
  }

  // void setQrImage(String orgId, String id) {
  //   setState(() {
  //     qr = QrImageView(
  //       data: id,
  //       size: 200,
  //       backgroundColor: Colors.white,
  //     );
  //   });
  // }

  // void setQrImage(String orgId, String id) {
  //   setState(() {
  //     qr = QrImageView(
  //       data: id,
  //       size: 200,
  //       backgroundColor: Colors.white,
  //     );
  //   });
  // }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        timeController.text = picked.format(context);
      });
    }
  }

  void _showDonateDialog(BuildContext context) {
    // Define the available donation items
    List<String> donationItems = ["Food", "Clothes", "Cash"];

    // Initialize a list to hold the selected items
    List<String> selectedItems = [];

    File? selectedPhoto;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future<void> pickImage() async {
          final image =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (image != null) {
            setState(() {
              selectedPhoto = File(image.path);
            });
          }
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Donate to Organization"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Checkbox group for donation items
                    for (String item in donationItems)
                      CheckboxListTile(
                        title: Text(item),
                        value: selectedItems.contains(item),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              // If checkbox is checked, add item to selectedItems
                              selectedItems.add(item);
                            } else {
                              // If checkbox is unchecked, remove item from selectedItems
                              selectedItems.remove(item);
                            }
                          });
                        },
                      ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: deliveryController,
                      decoration:
                          InputDecoration(labelText: "Pickup or Drop off"),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: weightController,
                      decoration:
                          InputDecoration(labelText: "Weight of donation (kg)"),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Date',
                        labelText: 'Enter Date',
                      ),
                      onTap: () async {
                        await _pickDate(context);
                      },
                    ),
                    TextFormField(
                      controller: timeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Time',
                        labelText: 'Enter Time',
                      ),
                      onTap: () async {
                        await _pickTime(context);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                          labelText: "Address (for pickup option only)"),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: contactController,
                      decoration: InputDecoration(
                          labelText: "Contact Number (for pickup option only)"),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: pickImage,
                      child: Text("Upload Photo"),
                    ),
                    if (selectedPhoto != null) ...[
                      SizedBox(height: 10),
                      Image.file(selectedPhoto!),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? deliveryDateTime;
                    if (selectedDate != null && selectedTime != null) {
                      deliveryDateTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      );
                    }

                    Donation donation = Donation(
                      dateCreated: DateTime.now(),
                      item: selectedItems,
                      delivery: deliveryController.text,
                      weight: double.parse(weightController.text),
                      dateDelivery: deliveryDateTime ?? DateTime.now(),
                      address: [addressController.text],
                      contact: contactController.text,
                      donorId: user!.uid,
                      orgId: '',
                      photo: "",
                    );

                    print("huhhh");

                    // Add the donation to your provider
                    await context
                        .read<DonationListProvider>()
                        .addDonation(donation);
                    // Close the dialog
                    Navigator.pop(context);
                  },
                  child: Text("Submit"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

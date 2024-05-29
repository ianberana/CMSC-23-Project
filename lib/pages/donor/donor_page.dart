import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
//import '../../providers/donation_provider.dart';
import '../../models/donation_model.dart';
import 'donor_drawer.dart';

class DonorPage extends StatefulWidget {
  const DonorPage({Key? key}) : super(key: key);

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  File? photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DonorDrawer(),
      appBar: AppBar(
        title: const Text("Donors Page"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Red Cross Youth of UPLB"),
            subtitle: Text("The Red Cross Youth of University of the Philippines Los Banos is a non profit, mass based, student civic organization that aims to uphold humanity as one of its principles."),
            onTap: () {
              _showDonateDialog(context);
            },
          ),
          ListTile(
            title: Text("Umalohokan, Inc."),
            subtitle: Text("Umalohokan, Inc. is a socio-cultural organization founded on December 21, 1977 in the University of the Philippines-Los Baños, at the height of the 1972 Martial Law."),
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

          // Donation donation = Donation(
          //   dateCreated: DateTime.now(),
          //   item: "food",
          //   delivery: "pickup",
          //   weight: 20,
          //   dateDelivery: DateTime.now(),
          //   address: ["Los Banos, Laguna"],
          //   contact: "09123456789",
          //   donorId: "VLYloaQO4QwZS8Ve0ouE",
          // );
          // await context
          //     .read<DonationListProvider>()
          //     .addDonation(donation, photo!);
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Future<File?> pickImageFromGallery() async {
    final image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    } else {
      return File(image.path);
    }
  }

  Future<File?> pickImageFromCamera() async {
    final image =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    } else {
      return File(image.path);
    }
  }

  void _showDonateDialog(BuildContext context) {
  // Define the available donation items
  List<String> donationItems = ["Food", "Clothes", "Cash"];

  // Initialize a list to hold the selected items
  List<String> selectedItems = [];

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Donate to Organization",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
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
                decoration: InputDecoration(labelText: "Pickup or Drop off"),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Weight of donation (kg)"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Date and Time of pickup/drop off"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                //   Donation donation = Donation(
                //   dateCreated: DateTime.now(),
                //   item: "food",
                //   delivery: "pickup",
                //   weight: 20,
                //   dateDelivery: DateTime.now(),
                //   address: ["Los Banos, Laguna"],
                //   contact: "09123456789",
                //   donorId: "VLYloaQO4QwZS8Ve0ouE",
                // );
                  Navigator.pop(context);
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      );
    },
  );
}


}

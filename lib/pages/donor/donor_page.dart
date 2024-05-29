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
              // Add action when Organization 1 is tapped
            },
          ),
          ListTile(
            title: Text("Umalohokan Inc."),
            subtitle: Text("Umalohokan, Inc. is a socio-cultural organization founded on December 21, 1977 in the University of the Philippines-Los Baños, at the height of the 1972 Martial Law."),
            onTap: () {
              // Add action when Organization 2 is tapped
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
}

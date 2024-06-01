import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/donor_model.dart';

class AdminDonorProfile extends StatefulWidget {
  final Donor donor;
  const AdminDonorProfile({required this.donor});

  @override
  State<AdminDonorProfile> createState() => _AdminDonorProfileState();
}

class _AdminDonorProfileState extends State<AdminDonorProfile> {
  // bool isDonationOpen = true;

  // void toggleDonationStatus() async {
  //   setState(() {
  //     isDonationOpen = !isDonationOpen;
  //   });

  //   await context.read<OrgListProvider>().updateStatus(isDonationOpen);
  // }

  @override
  Widget build(BuildContext context) {
    // Organization? org = context.watch<OrgListProvider>().currentOrg;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF008080),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to the desired color
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: Center(child: Icon(Icons.person, size: 80)),
              ),
              SizedBox(height: 16),
              Text(
                widget.donor.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildContactRow(
                          Icons.phone, 'Contact Number', widget.donor.contact),
                      SizedBox(height: 8),
                      _buildContactRow(
                          Icons.email, 'Email', widget.donor.email),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      color: Color(0xFF008080),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String info) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Expanded(child: Text(info)),
      ],
    );
  }
}

import 'package:elbi_donate/models/org_model.dart';
import 'package:elbi_donate/pages/organization/org_drawer.dart';
import 'package:elbi_donate/providers/org_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class OrganizationProfile extends StatefulWidget {
  @override
  _OrganizationProfileState createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile> {
  bool isDonationOpen = true;

  void toggleDonationStatus() async {
    setState(() {
      isDonationOpen = !isDonationOpen;
    });

    await context.read<OrgListProvider>().updateStatus(isDonationOpen);
  }

  @override
  Widget build(BuildContext context) {
    Organization? org = context.watch<OrgListProvider>().currentOrg;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF008080),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to the desired color
        ),
      ),
      drawer: OrgDrawer(),
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
                org!.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Status for donation: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: toggleDonationStatus,
                    style: TextButton.styleFrom(
                      backgroundColor: isDonationOpen ? Color(0xFF008080) : Color.fromARGB(
                                                  255, 187, 57, 47)
                    ),
                    child: Text(
                      isDonationOpen ? 'Open' : 'Close',
                      style: TextStyle(color: isDonationOpen ? Colors.white : Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard('Donations', '1K+'),
                  _buildStatCard('Drives', '12K+'),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Felis tristique euismod odio ipsum senectus commodo. Ullamcorper '
                'ac tellus porta ipsum mattis sed vivamus metus. Et tellus diam. '
                'Ullamcorper ac tellus porta ipsum mattis sed vivamus.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildContactRow(Icons.location_on, 'Address',
                          'Westbrook Residences, Batong Malake, Laguna'),
                      SizedBox(height: 8),
                      _buildContactRow(Icons.phone, 'Contact Number',
                          '09496022575'),
                      SizedBox(height: 8),
                      _buildContactRow(
                          Icons.email, 'Email', 'mtalarcon1@up.edu.ph'),
                    ],
                  ),
                ),
              ),
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

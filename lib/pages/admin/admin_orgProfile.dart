import 'package:elbi_donate/models/org_model.dart';
import 'package:elbi_donate/pages/organization/org_drawer.dart';
import 'package:elbi_donate/providers/org_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AdminOrgProfile extends StatefulWidget {
  final Organization org;
  const AdminOrgProfile({required this.org});

  @override
  State<AdminOrgProfile> createState() => _AdminOrgProfileState();
}

class _AdminOrgProfileState extends State<AdminOrgProfile> {
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
                widget.org.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Status for donation: ${widget.org.status ? "Open" : "Closed"}',
                    style: TextStyle(fontSize: 16),
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
                      _buildContactRow(
                          Icons.phone, 'Contact Number', widget.org.contact),
                      SizedBox(height: 8),
                      _buildContactRow(Icons.email, 'Email', widget.org.email),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Proof of Legitamacy',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              ConstrainedBox(
                  constraints: BoxConstraints(
                    // Set the maximum width for the viewer
                    maxHeight: 500, // Set the maximum height for the viewer
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Color of the outline
                            width: 2.0, // Width of the outline
                          ),
                          borderRadius: BorderRadius.circular(12.0)),
                      height: 500,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              12.0), // Same radius for clipping
                          child: InteractiveViewer(
                            child: SfPdfViewer.network(widget.org.proof!),
                          ))))
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

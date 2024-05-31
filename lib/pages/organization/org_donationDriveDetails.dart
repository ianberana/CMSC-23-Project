import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donate/models/donation_model.dart';
import 'package:elbi_donate/models/drive_model.dart';
import 'package:elbi_donate/models/org_model.dart';
import 'package:elbi_donate/pages/organization/drive_modal.dart';
import 'package:elbi_donate/pages/organization/linkdonations.dart';
import 'package:elbi_donate/providers/donation_provider.dart';
import 'package:elbi_donate/providers/org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgDonationDriveDetails extends StatelessWidget {
  final Drive drive;

  OrgDonationDriveDetails({required this.drive});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Drive Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.grey[300],
            ),
            SizedBox(height: 16),
            Text(
              '${drive.name}\n${drive.dateCreated}',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              '${drive.description}',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LinkDonationsPage(driveItem: drive),
                  ),
                );
              },
              child: Text('Link Donation'),
            ),
            DonationList(
                driveId: drive.id!), // This should be a widget that lists the donations
          ],
        ),
      ),
    );
  }
}

class DonationList extends StatelessWidget {
  final String driveId;

  DonationList({required this.driveId});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donationStream =
        context.watch<DonationListProvider>().getOrgDonations(driveId);

    return StreamBuilder<QuerySnapshot>(
      stream: donationStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No donations yet'));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              Donation donation =
                  Donation.fromJson(doc.data() as Map<String, dynamic>);
              donation.id = doc.id;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: ListTile(
                  title: Text('${donation.id}'),
                  subtitle: Text('${donation.dateCreated}'),
                ),
              );
            },
          );
        }
      },
    );
  }
}

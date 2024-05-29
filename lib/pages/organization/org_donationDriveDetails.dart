import 'package:elbi_donate/models/drive_model.dart';
import 'package:flutter/material.dart';

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
              '${drive.name}\n${drive.date}',
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
              onPressed: () {},
              child: Text('Link Donation'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class OrgDonationDriveDetails extends StatelessWidget {
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
              'Magenta Alarcon Drive\n12-02-2020',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Felis tristique euismod odio ipsum senectus commodo. Ullamcorper ac tellus porta ipsum mattis sed vivamus metus. Et tellus diam. Ullamcorper ac tellus porta ipsum mattis sed vivamus.',
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
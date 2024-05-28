import 'package:elbi_donate/pages/organization/org_donationDetails.dart';
import 'package:elbi_donate/pages/organization/org_donationDriveDetails.dart';
import 'package:elbi_donate/pages/organization/org_drawer.dart';
import 'package:elbi_donate/pages/organization/org_page.dart';
import 'package:flutter/material.dart';

class OrgDonationDrive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Drive',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF008080),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to the desired color
        ),
      ),
      drawer: OrgDrawer(),
      body: Container(
        color: Color(0xFF008080),
        child: ListView(
          children: [
            DonationDriveCard(),
            DonationDriveCard(),
            DonationDriveCard(),
            DonationDriveCard(),
            DonationDriveCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //add functionality
        },
        child: Icon(Icons.add, size:30),
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF008080),
      ),
    );
  }
}

class DonationDriveCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          'Magenta Alarcon Drive',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3,),
            Text('Date Created: 12-02-2020'),
            SizedBox(height: 3,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrganizationPage()),
                );
              },
              child: const Text(
                'Donation Details >',
                style: TextStyle(
                  color: Color(0xFF008080),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        trailing: Wrap(
          spacing: 10, // space between two icons
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                  //edit functionality
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                   //delete functionality
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrgDonationDriveDetails()),
          );
        },
      ),
    );
  }
}

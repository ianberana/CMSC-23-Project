import 'package:elbi_donate/pages/organization/org_donationDrive.dart';
import 'package:elbi_donate/pages/organization/org_page.dart';
import 'package:elbi_donate/pages/organization/org_profile.dart';
import 'package:elbi_donate/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF008080),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Donations'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OrganizationPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.details),
            title: Text('Donation Drives'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OrgDonationDrive()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OrganizationProfile()),
              );
            },
          ),
          ListTile(
          title: const Text('Logout'),
          onTap: () {
            context.read<UserAuthProvider>().signOut();
            Navigator.pop(context);
          },
        ),
        ],
      ),
    );
  }
}
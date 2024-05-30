import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donate/models/donation_model.dart';
import 'package:elbi_donate/models/donor_model.dart';
import 'package:elbi_donate/pages/organization/org_donationDetails.dart';
import 'package:elbi_donate/pages/organization/org_donationDrive.dart';
import 'package:elbi_donate/pages/organization/org_drawer.dart';
import 'package:elbi_donate/providers/donor_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/donation_model.dart';
import '../../models/drive_model.dart';
import '../../models/org_model.dart';
import '../../providers/auth_provider.dart';
// import '../../providers/donation_provider.dart';
import '../../providers/drive_provider.dart';
import '../../providers/org_provider.dart';
// import 'org_profile.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  String status = 'Pending';
  @override
  Widget build(BuildContext context) {
    Organization? org = context.watch<OrgListProvider>().currentOrg;
    // Stream<QuerySnapshot> driveStream =
    //     context.watch<DriveListProvider>().getOrgDrives(org!.id!);
    Stream<QuerySnapshot> donationStream =
        context.watch<DonationListProvider>().getOrgDonations(org!.id!);
    return Scaffold(
      appBar: AppBar(
        title: Text('Donations',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF008080),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to the desired color
        ),
      ),
      drawer: OrgDrawer(),
      body: Container(
        color: Color(0xFF008080),
        child: StreamBuilder(
          stream: donorStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error encountered! ${snapshot.error}"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("No Donations Yet"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: ((context, index) {
                Donor donor = Donor.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
                donor.id = snapshot.data?.docs[index].id;

                return Dismissible(
                  key: Key(donor.id.toString()),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: ListTile(
                      title: Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${donor.name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone_callback,
                                      size: 16.0,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text('${donor.contact}'),
                                  ],
                                ),
                                SizedBox(height: 3.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 16.0,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text('12-02-2020'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IntrinsicWidth(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton<String>(
                                  value: status,
                                  items: ['Pending', 'Accepted', 'Completed']
                                      .map((status) {
                                    return DropdownMenuItem<String>(
                                      value: status,
                                      child: Text(status),
                                    );
                                  }).toList(),
                                  onChanged: (newStatus) {
                                    setState(() {
                                      status = newStatus!;
                                    });
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF008080),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                  ),
                                  child: Text(
                                    'Link Donation',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrgDonationDetails()),
                        );
                      },
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
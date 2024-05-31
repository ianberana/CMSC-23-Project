import 'package:elbi_donate/models/donation_model.dart';
import 'package:elbi_donate/models/donor_model.dart';
import 'package:elbi_donate/models/drive_model.dart';
import 'package:elbi_donate/models/org_model.dart';
import 'package:elbi_donate/providers/donation_provider.dart';
import 'package:elbi_donate/providers/org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LinkDonationsPage extends StatelessWidget {
  final Drive driveItem; 

  LinkDonationsPage({required this.driveItem});

  @override
  Widget build(BuildContext context) {
    Organization? org = context.watch<OrgListProvider>().currentOrg;
    Stream<QuerySnapshot> donationStream =
        context.watch<DonationListProvider>().getOrgDonations(org!.id!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Donations', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF008080),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: donationStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No confirmed donations found'));
          } else {

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                Donation donation = Donation.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
                donation.id = snapshot.data?.docs[index].id;

                if (donation.status == "confirmed" ||
                    donation.status == "scheduled") {
                  return FutureBuilder<Donor>(
                    future: context
                        .read<DonationListProvider>()
                        .getDonorDetails(donation.donorId),
                    builder: (context, donorSnapshot) {
                      if (donorSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (donorSnapshot.hasError) {
                        return Text("Error: ${donorSnapshot.error}");
                      } else if (!donorSnapshot.hasData) {
                        return Text("Donor not found");
                      }

                      Donor donor = donorSnapshot.data!;

                      return Card(
                        color: Color(0xFF008080),
                        margin:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
                                        Text('${donation.dateCreated}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await context
                                      .read<DonationListProvider>()
                                      .completeDonation(donation.id!, driveItem.id!);
                                  Navigator.pop(context);
                                },
                                child: Text('Link'),
                              ),
                            ],
                          ),
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => OrgDonationDetails(donation_: donation),
                          //     ),
                          //   );
                          // },
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

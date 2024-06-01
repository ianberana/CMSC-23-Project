import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donate/models/donation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/donor_model.dart';
import '../../models/org_model.dart';
import '../../providers/donation_provider.dart';
import '../../providers/org_provider.dart';
import 'admin_donationDetails.dart';
import 'admin_drawer.dart';

class AdminDonationsPage extends StatefulWidget {
  const AdminDonationsPage({super.key});

  @override
  State<AdminDonationsPage> createState() => _AdminDonationsPageState();
}

class _AdminDonationsPageState extends State<AdminDonationsPage> {
  // bool isChecked = false;
  // bool isCancelled = false;

  // void toggleCheck(Donation donation) async {
  //   if (!isChecked && !isCancelled) {
  //     String status =
  //         donation.delivery == 'drop off' ? 'confirmed' : 'scheduled';

  //     setState(() {
  //       isChecked = true;
  //     });

  //     await context
  //         .read<DonationListProvider>()
  //         .confirmDonation(donation.id!, status);
  //   }
  // }

  // void cancelDonation(Donation donation) async {
  //   if (!isCancelled && !isChecked) {
  //     setState(() {
  //       isCancelled = true;
  //     });

  //     await context
  //         .read<DonationListProvider>()
  //         .confirmDonation(donation.id!, 'cancelled');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Organization? org = context.watch<OrgListProvider>().currentOrg;
    // Stream<QuerySnapshot> driveStream =
    //     context.watch<DriveListProvider>().getOrgDrives(org!.id!);
    // Stream<QuerySnapshot> orgStream =
    //     context.watch<OrgListProvider>().getAllOrganizations;

    Stream<QuerySnapshot> donationStream =
        context.watch<DonationListProvider>().getAllDonations;

    return Scaffold(
      appBar: AppBar(
        title: Text('Donations',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF008080),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to the desired color
        ),
      ),
      drawer: AdminDrawer(),
      body: Container(
        color: Color(0xFF008080),
        child: StreamBuilder(
          stream: donationStream,
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
                Donation donation = Donation.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
                donation.id = snapshot.data?.docs[index].id;

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

                      return Dismissible(
                        key: Key(donation.id.toString()),
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: ListTile(
                            title: Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Color(0xFF008080),
                                      backgroundColor:
                                          Color.fromARGB(255, 63, 172, 67),
                                    ),
                                    onPressed: null,
                                    child: Text(donation.status,
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminDonationDetails(
                                        donation_: donation)),
                              );
                            },
                          ),
                        ),
                      );
                    });
              }),
            );
          },
        ),
      ),
    );
  }
}

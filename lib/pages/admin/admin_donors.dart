import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/donation_model.dart';
import '../../models/donor_model.dart';
import '../../models/org_model.dart';
import '../../providers/donation_provider.dart';
import '../../providers/donor_provider.dart';
import '../../providers/org_provider.dart';
import 'admin_donorProfile.dart';
import 'admin_drawer.dart';
import 'admin_orgProfile.dart';

class AdminDonorsPage extends StatefulWidget {
  const AdminDonorsPage({super.key});

  @override
  State<AdminDonorsPage> createState() => _AdminDonorsPageState();
}

class _AdminDonorsPageState extends State<AdminDonorsPage> {
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
    Stream<QuerySnapshot> donorStream =
        context.watch<DonorListProvider>().getAllDonors;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Donors', style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF008080),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to the desired color
        ),
      ),
      drawer: AdminDrawer(),
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

                return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 30,
                      ),
                      title: Text(
                        "${donor.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3),
                          Text('${donor.contact}'),
                        ],
                      ),
                      // trailing: org.approved
                      //     ? ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //             foregroundColor: Colors.white,
                      //             backgroundColor: Colors.grey),
                      //         onPressed: () {},
                      //         child: Text("Approved"))
                      //     : ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //           foregroundColor: Color(0xFF008080),
                      //           backgroundColor:
                      //               Color.fromARGB(255, 63, 172, 67),
                      //         ),
                      //         onPressed: () => context
                      //             .read<OrgListProvider>()
                      //             .approveOrganization(org.id!),
                      //         child: Text('Approve',
                      //             style: TextStyle(color: Colors.white)),
                      //       ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdminDonorProfile(donor: donor)),
                        );
                      },
                    ));
              }),
            );
          },
        ),
      ),
    );
  }
}

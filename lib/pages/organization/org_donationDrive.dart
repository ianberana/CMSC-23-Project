import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donate/models/drive_model.dart';
import 'package:elbi_donate/pages/organization/drive_modal.dart';
import 'package:elbi_donate/pages/organization/org_donationDetails.dart';
import 'package:elbi_donate/pages/organization/org_donationDriveDetails.dart';
import 'package:elbi_donate/pages/organization/org_drawer.dart';
import 'package:elbi_donate/pages/organization/org_page.dart';
import 'package:elbi_donate/providers/drive_provider.dart';
import 'package:elbi_donate/providers/org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgDonationDrive extends StatelessWidget {
  String formatTimestamp(DateTime timestamp) {
    String month = timestamp.month.toString();
    String day = timestamp.day.toString();
    String year = timestamp.year.toString();
    String period = timestamp.hour < 12 ? 'AM' : 'PM';
    int hour = timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour;
    String minute = timestamp.minute.toString().padLeft(2, '0');
    return '$month-$day-$year || $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final orgListProvider = context.read<OrgListProvider>();
    final orgId = orgListProvider.currentOrg?.id;
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
        child: StreamBuilder(
          stream: context.read<DriveListProvider>().getOrgDrives(orgId!),
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
                child: Text("No Donation Drives Yet"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: ((context, index) {
                Drive drive = Drive.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
                drive.id = snapshot.data?.docs[index].id;
                return Dismissible(
                  key: Key(drive.id.toString()),
                  onDismissed: (direction) {
                    context.read<DriveListProvider>().deleteDrive(drive.name);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${drive.name} dismissed')));
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  child: Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      title: Text(
                        "${drive.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3),
                          Text('${formatTimestamp(drive.dateCreated)}'),
                          // SizedBox(height: 3),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => OrgDonationDetails()),
                          //     );
                          //   },
                          //   child: const Text(
                          //     'Donation Details >',
                          //     style: TextStyle(
                          //       color: Color(0xFF008080),
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 10, // space between two icons
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              //edit functionality
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => DriveModal(
                                  type: 'Edit',
                                  driveItem: drive,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              //delete functionality
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => DriveModal(
                                  type: 'Delete',
                                  driveItem: drive,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrgDonationDriveDetails(drive: drive)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => DriveModal(
              type: 'Add',
              driveItem: null,
            ),
          );
        },
        child: Icon(Icons.add, size: 30),
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF008080),
      ),
    );
  }
}

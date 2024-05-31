import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbi_donate/models/donation_model.dart';
import 'package:elbi_donate/models/donor_model.dart';
import 'package:elbi_donate/providers/donation_provider.dart';

class OrgDonationDetails extends StatelessWidget {
  final Donation donation_;

  OrgDonationDetails({required this.donation_});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    DateTime generateRandomDateTimeAfter(DateTime creationDate) {
      Random random = Random();
      int randomDays = random.nextInt(3) + 3;
      return creationDate.add(Duration(days: randomDays));
    }

    String formatTimestamp(DateTime timestamp) {
      String month = timestamp.month.toString();
      String day = timestamp.day.toString();
      String year = timestamp.year.toString();
      String period = timestamp.hour < 12 ? 'AM' : 'PM';
      int hour = timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour;
      String minute = timestamp.minute.toString().padLeft(2, '0');
      return '$month-$day-$year || $hour:$minute $period';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008080),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([
          context
              .read<DonationListProvider>()
              .fetchDonationDetails(donation_.id!),
          context
              .read<DonationListProvider>()
              .fetchDonorDetails(donation_.donorId)
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<DonationListProvider>(
              builder: (context, provider, child) {
                Donation? donation = provider.donation;
                Donor? donor = provider.donor;

                if (donation == null || donor == null) {
                  return Center(
                      child: Text('No donation or donor details available.'));
                }

                return Stack(children: [
                  Positioned(
                    left: 0,
                    child: Container(
                      width: screenWidth,
                      height: 170,
                      color: Color(0xFF008080),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 4.0,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundColor: Color(0xFF008080),
                                  child: Icon(
                                    Icons.volunteer_activism,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Donation ${donation.status}',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                DropdownButton<String>(
                                  value: donation.status,
                                  items: ['pending', 'Accepted', 'Completed']
                                      .map((status) {
                                    return DropdownMenuItem<String>(
                                      value: status,
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newStatus) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Wrap(
                          spacing: 8.0,
                          children: donation.item.split(',').map((category) {
                            return Chip(
                              label: Text(category
                                  .trim()), // Trim to remove leading/trailing whitespace
                              backgroundColor: Color(0xFF008080),
                              labelStyle: TextStyle(color: Colors.white),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16.0),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 4.0,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24.0,
                                ),
                                SizedBox(width: 16.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      donor.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      'Donor',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.call, color: Colors.teal),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.message, color: Colors.teal),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 4.0,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.monitor_weight),
                                    SizedBox(width: 8.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Weight',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          '${donation.weight}',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.access_time),
                                    SizedBox(width: 8.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pickup Time',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          '${formatTimestamp(generateRandomDateTimeAfter(donation.dateCreated))}',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on),
                                    SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pickup Address',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                donation.address.map((part) {
                                              return Text(
                                                part,
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Photos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        // Add photos widget here
                      ],
                    ),
                  ),
                ]);
              },
            );
          }
        },
      ),
    );
  }
}

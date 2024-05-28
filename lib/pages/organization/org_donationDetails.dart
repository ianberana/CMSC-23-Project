import 'package:flutter/material.dart';

class OrgDonationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Hardcode data
    String donorName = 'Magen Alarcon';
    String donorPhotoUrl =
        'https://via.placeholder.com/150'; // Placeholder image URL
    String weight = '100 lbs';
    String pickupTime = 'Wed Jan 2, 12:30 am';
    String pickupAddress =
        'Ishika, Sharma Mention, DP Garden, Lucknow 123456789';
    String status = 'Pending';
    List<String> categories = ['Food', 'Clothes', 'Cash', 'Necessities'];
    List<String> photos = [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150'
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF008080),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to the desired color
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(children: [
        Positioned(
          left: 0, // Position the rectangle on the left half
          child: Container(
            width: screenWidth, // Half the width of the card
            height: 170, // Same height as the card
            color: Color(0xFF008080), // Color of the rectangle
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
                          radius: 50.0, // Adjust the radius as needed
                          backgroundColor: Color(0xFF008080),
                          child: Icon(
                            Icons.volunteer_activism,
                            size: 50,
                            color: Colors.white,
                          )),
                      SizedBox(height: 16.0),
                      Text(
                        'Donation Accepted',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      DropdownButton<String>(
                        value: status,
                        items:
                            ['Pending', 'Accepted', 'Completed'].map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status, style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 18),),
                          );
                        }).toList(),
                        onChanged: (newStatus) {
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                children: categories.map((category) {
                  return Chip(
                    label: Text(category),
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
                        backgroundImage: NetworkImage(donorPhotoUrl),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            donorName,
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
                        onPressed: () {
                          // Call donor action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.message, color: Colors.teal),
                        onPressed: () {
                          // Message donor action
                        },
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                weight,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                pickupTime,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pickup Address',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Container(
                                padding: new EdgeInsets.only(right: 5.0),
                                child: Text(
                                  pickupAddress,
                                  style: TextStyle(
                                      fontSize: 16.0), // Handle overflow
                                ),
                              )
                            ],
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
              Container(
                height: 100.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    String photoUrl = photos[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Image.network(photoUrl),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

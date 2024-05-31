import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donate/models/user_model.dart';
import 'package:elbi_donate/providers/auth_provider.dart';
import 'package:elbi_donate/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../models/donation_model.dart';
import 'donor_drawer.dart';

class DonationListPage extends StatelessWidget {
  const DonationListPage({Key? key}) : super(key: key);
  Widget donationsListTile(BuildContext context, donations) {
    List<Widget> _donationsListTileWidget = [];
    if (donations.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text("No Donations To Show"),
          ],
        ),
      );
    } else {
      donations.forEach((element) {
        Donation donation = Donation.fromJson(element.data() as Map<String, dynamic>);
        donation.id = element.id!;
        _donationsListTileWidget.add(
          Padding(
            padding: EdgeInsets.only(bottom: 30, right: 30, left: 30),
            child: ListTile(
              leading: Icon(
                Icons.people,
                size: 20,
              ),
              title: Text(donation.donorId),
              tileColor: Colors.black12,
              trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    context.read<DonationListProvider>().cancelDonation(context.read<UserAuthProvider>().user!.uid);
                  },
                ),
              ],
            ),
            ),
          ),
        );
      });
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _donationsListTileWidget,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donationsStream = context.watch<DonationListProvider>().getDonorDonations(context.read<UserAuthProvider>().user!.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text("Donations List"),
      ),
      drawer: DonorDrawer(),
      body: StreamBuilder(
        stream: donationsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("No Donations Found"),
            );
          }

          List<QueryDocumentSnapshot<Object?>>? donations = snapshot.data?.docs;

          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Text(
                      'Donation List',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Color.fromARGB(255, 71, 188, 184),
                      ),
                    ),
                  ),
                  donationsListTile(context, donations),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
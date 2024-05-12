/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import '../../providers/auth_provider.dart';
import '../../providers/org_provider.dart';
import '../donor/donor_page.dart';

class OrganizationView extends StatefulWidget {
  const OrganizationView({super.key});

  @override
  State<OrganizationView> createState() => _OrganizationViewState();
}

class _OrganizationViewState extends State<OrganizationView> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> orgStream =
        context.read<OrgListProvider>().getOrganizations;

    return StreamBuilder(
        stream: orgStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error encountered! ${snapshot.error}"),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapshot.hasData) {
            return const DonorPage();
          }

          String? currentuser = context.watch<UserAuthProvider>().user!.email;
          // Iterate over each document
          for (var organization in snapshot.data!.docs) {
            Map<String, dynamic> data =
                organization.data() as Map<String, dynamic>;
            // Check if the value exists in any field of the document
            if (data.containsValue(currentuser)) {
              // Value exists in at least one document
              // print('Value exists in document ${docSnapshot.id}');
              return Container(); // Exit function early since we found the value
            }
          }

          return DonorPage();
        });
  }
}

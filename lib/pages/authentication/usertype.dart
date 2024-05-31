/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/org_model.dart';
import '../../providers/donor_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/org_provider.dart';
import '../admin/admin_page.dart';
import '../donor/donor_page.dart';
import '../organization/org_page.dart';
import '../organization/org_qr.dart';
import 'signin.dart';

class UserType extends StatefulWidget {
  final String email;
  const UserType(this.email, {super.key});

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> userStream =
        context.read<UserProvider>().getUser(widget.email);

    return StreamBuilder(
        stream: userStream,
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
            return SignInPage();
          }

          final user = snapshot.data!.docs.first;
          if (user['type'] == "admin")
            return AdminPage();
          else if (user['type'] == "organization") {
            return FutureBuilder(
              future: context.read<OrgListProvider>().setCurrentOrg(user['id']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error encountered! ${snapshot.error}"),
                    ),
                  );
                } else {
                  final org = context.watch<OrgListProvider>().currentOrg;
                  if (org!.approved) {
                    return OrganizationQrPage();
                  } else {
                    return SignInPage();
                  }
                }
              },
            );
          } else if (user['type'] == "user") {
            context.read<DonorListProvider>().setCurrentDonor(user['id']);
            return DonorPage();
          }

          return SignInPage();
        });
  }
}

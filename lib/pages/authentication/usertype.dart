/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../admin/admin_page.dart';
import '../donor/donor_page.dart';
import '../organization/org_page.dart';
import 'signin.dart';

class UserType extends StatefulWidget {
  const UserType({super.key});

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> userStream =
        context.read<UserProvider>().getUserTypes;

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

          String? currentuser = context.watch<UserAuthProvider>().user!.email;
          // Iterate over each document
          for (var user in snapshot.data!.docs) {
            Map<String, dynamic> data = user.data() as Map<String, dynamic>;
            // Check if the value exists in any field of the document
            if (data.containsValue(currentuser)) {
              if (data.containsValue("admin"))
                return AdminPage();
              else if (data.containsValue("organization"))
                return OrganizationPage();
              else if (data.containsValue("user")) return DonorPage();
            }
          }

          return SignInPage();
        });
  }
}

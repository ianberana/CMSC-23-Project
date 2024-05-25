import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class OrganizationProfile extends StatefulWidget {
  const OrganizationProfile({super.key});
  @override
  State<OrganizationProfile> createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile> {
  User? user;

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Email:",
                  style: TextStyle(fontSize: 20),
                ),
                Text(user!.email!, style: const TextStyle(fontSize: 20))
              ],
            ),
          ),
        ));
  }
}

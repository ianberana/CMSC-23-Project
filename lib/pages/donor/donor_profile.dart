import 'package:elbi_donate/pages/donor/donor_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class DonorProfile extends StatefulWidget {
  const DonorProfile({super.key});
  @override
  State<DonorProfile> createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  User? user;

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    return Scaffold(
        drawer: DonorDrawer(),
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
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donate/pages/donor/donor_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'donor_profile.dart';

class DonorPage extends StatefulWidget {
  const DonorPage({super.key});

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DonorDrawer(),
        appBar: AppBar(
          title: const Text("Donors Page"),
        ),
        body: Container()
        
        );
  }
  
}

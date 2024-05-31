import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../models/donation_model.dart';
import '../../models/drive_model.dart';
import '../../models/org_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/donation_provider.dart';
import '../../providers/drive_provider.dart';
import '../../providers/org_provider.dart';
import 'org_profile.dart';

class OrganizationQrPage extends StatefulWidget {
  const OrganizationQrPage({super.key});

  @override
  State<OrganizationQrPage> createState() => _OrganizationQrPageState();
}

class _OrganizationQrPageState extends State<OrganizationQrPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
  Barcode? info;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    Organization? org = context.watch<OrgListProvider>().currentOrg;
    // Stream<QuerySnapshot> driveStream =
    //     context.watch<DriveListProvider>().getOrgDrives(org!.id!);

    if (info != null) {
      List id = info!.code!.split(" ");
    }

    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: const Text("Organization Page"),
      ),
      body: Stack(alignment: Alignment.center, children: <Widget>[
        scanQr(context),
        Text(info != null ? "${info!.code}" : "No code")
      ]),
      // StreamBuilder(
      //   stream: donationStream,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(
      //         child: Text("Error encountered! ${snapshot.error}"),
      //       );
      //     } else if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (!snapshot.hasData) {
      //       return const Center(
      //         child: Text("No Drives Found"),
      //       );
      //     }

      //     return ListView.builder(
      //       itemCount: snapshot.data?.docs.length,
      //       itemBuilder: ((context, index) {
      //         Donation donation = Donation.fromJson(
      //             snapshot.data?.docs[index].data() as Map<String, dynamic>);
      //         print(donation.orgId);
      //         return ListTile(title: Text(donation.orgId));
      // todo.id = snapshot.data?.docs[index].id;
      // return Dismissible(
      //   key: Key(todo.id.toString()),
      //   onDismissed: (direction) {
      //     context.read<TodoListProvider>().deleteTodo(todo.title);

      //     ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('${todo.title} dismissed')));
      //   },
      //   background: Container(
      //     color: Colors.red,
      //     child: const Icon(Icons.delete),
      //   ),
      //   child: ListTile(
      //     title: Text(todo.title),
      //     leading: Checkbox(
      //       value: todo.completed,
      //       onChanged: (bool? value) {
      //         context
      //             .read<TodoListProvider>()
      //             .toggleStatus(todo.id!, value!);
      //       },
      //     ),
      //     trailing: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         IconButton(
      //           onPressed: () {
      //             showDialog(
      //               context: context,
      //               builder: (BuildContext context) => TodoModal(
      //                 type: 'Edit',
      //                 item: todo,
      //               ),
      //             );
      //           },
      //           icon: const Icon(Icons.create_outlined),
      //         ),
      //         IconButton(
      //           onPressed: () {
      //             showDialog(
      //               context: context,
      //               builder: (BuildContext context) => TodoModal(
      //                 type: 'Delete',
      //                 item: todo,
      //               ),
      //             );
      //           },
      //           icon: const Icon(Icons.delete_outlined),
      //         )
      //       ],
      //     ),
      //   ),
      // );
      //     }),
      //   );
      // },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) => TodoModal(
          //     type: 'Add',
          //     item: null,
          //   ),
          // );

          // UPDATE DONATION status
          // await context
          //     .read<DonationListProvider>()
          //     .updateStatus("rXoXxDLGvSofgG1IRlH4", "completed");

          // UPDATE ORGANIZATION status
          // await context
          //     .read<OrgListProvider>()
          //     .updateStatus("GCGt6AMZLTHbzlWdWXse", true);

          // CREATE DONATION DRIVE
          // Drive drive = Drive(
          //     dateCreated: DateTime.now(),
          //     name: "Typhoon Aghon",
          //     description: "Help victims",
          //     contact: org.contact,
          //     email: org.email,
          //     orgId: org.id!);
          // await context.read<DriveListProvider>().addDrive(drive);

          // // Link DONATION to DONATION DRIVE
          // File? photo = await pickImageFromGallery();

          // await context.read<DonationListProvider>().confirmDonation(
          //     "rXoXxDLGvSofgG1IRlH4", "X8SHToo4sH9pJSLkL3AG", photo!);

          // UPDATE DONATION DRIVE
          // Drive drive = Drive(
          //     name: "Typhoon Aghon Relief Care",
          //     description: "Help Typhoon Aghon victims to stand up again.",
          //     contact: "09000000000",
          //     email: "legacy@gmail.com");
          // await context
          //     .read<DriveListProvider>()
          //     .editDrive(drive, "X8SHToo4sH9pJSLkL3AG");

          // DELETE DONATION DRIVE
          // await context
          //     .read<DriveListProvider>()
          //     .deleteDrive("1bTkhBGmENhtK6A2eT3u");
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Widget scanQr(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;

      controller.scannedDataStream.listen((barcode) => setState(() {
            info = barcode;
          }));
    });
  }

  Future<File?> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    } else {
      return File(image.path);
    }
  }

  Drawer get drawer => Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(child: Text("Elbi Donate")),
        ListTile(
          title: const Text('Details'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrganizationProfile()));
          },
        ),
        ListTile(
          title: const Text('Donate'),
          onTap: () {
            // Navigator.pop(context);
            // Navigator.pushNamed(context, "/");
          },
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            context.read<UserAuthProvider>().signOut();
            Navigator.pop(context);
          },
        ),
      ]));
}

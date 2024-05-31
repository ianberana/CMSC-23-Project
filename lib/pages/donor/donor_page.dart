// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../models/donor_model.dart';
import '../../models/donation_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/donation_provider.dart';
import '../../providers/donor_provider.dart';
import 'donor_profile.dart';

class DonorPage extends StatefulWidget {
  const DonorPage({super.key});

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  File? photo;
  QrImageView? qr;

  @override
  Widget build(BuildContext context) {
    Donor? donor = context.watch<DonorListProvider>().currentDonor;
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: const Text("Donors Page"),
      ),
      body: Container(child: qr != null ? qr as Widget : Text("No qr")),
      // ),
      // StreamBuilder(
      //   stream: todosStream,
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
      //         child: Text("No Todos Found"),
      //       );
      //     }

      //     return ListView.builder(
      //       itemCount: snapshot.data?.docs.length,
      //       itemBuilder: ((context, index) {
      //         Todo todo = Todo.fromJson(
      //             snapshot.data?.docs[index].data() as Map<String, dynamic>);
      //         todo.id = snapshot.data?.docs[index].id;
      //         return Dismissible(
      //           key: Key(todo.id.toString()),
      //           onDismissed: (direction) {
      //             context.read<TodoListProvider>().deleteTodo(todo.title);

      //             ScaffoldMessenger.of(context).showSnackBar(
      //                 SnackBar(content: Text('${todo.title} dismissed')));
      //           },
      //           background: Container(
      //             color: Colors.red,
      //             child: const Icon(Icons.delete),
      //           ),
      //           child: ListTile(
      //             title: Text(todo.title),
      //             leading: Checkbox(
      //               value: todo.completed,
      //               onChanged: (bool? value) {
      //                 context
      //                     .read<TodoListProvider>()
      //                     .toggleStatus(todo.id!, value!);
      //               },
      //             ),
      //             trailing: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 IconButton(
      //                   onPressed: () {
      //                     showDialog(
      //                       context: context,
      //                       builder: (BuildContext context) => TodoModal(
      //                         type: 'Edit',
      //                         item: todo,
      //                       ),
      //                     );
      //                   },
      //                   icon: const Icon(Icons.create_outlined),
      //                 ),
      //                 IconButton(
      //                   onPressed: () {
      //                     showDialog(
      //                       context: context,
      //                       builder: (BuildContext context) => TodoModal(
      //                         type: 'Delete',
      //                         item: todo,
      //                       ),
      //                     );
      //                   },
      //                   icon: const Icon(Icons.delete_outlined),
      //                 )
      //               ],
      //             ),
      //           ),
      //         );
      //       }),
      //     );
      //   },
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

          // Add static donation
          File? photo = await pickImageFromCamera();

          Donation donation = Donation(
            dateCreated: DateTime.now(),
            item: ["food"],
            delivery: "pickup",
            weight: 20,
            dateDelivery: DateTime.now(),
            address: ["Los Banos, Laguna"],
            contact: "09123456789",
            donorId: donor!.id!,
            orgId: "7VI3RQEfEkEeBrJtzMZM",
          );
          String id = await context
              .read<DonationListProvider>()
              .addDonation(donation, photo!);

          setQrImage("7VI3RQEfEkEeBrJtzMZM", id);
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Future<File?> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    } else {
      return File(image.path);
    }
  }

  Future<File?> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    } else {
      return File(image.path);
    }
  }

  void setQrImage(String orgId, String id) {
    setState(() {
      qr = QrImageView(
        data: id,
        size: 200,
        backgroundColor: Colors.white,
      );
    });
  }

  Drawer get drawer => Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(child: Text("Elbi Donate")),
        ListTile(
          title: const Text('Details'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DonorProfile()));
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

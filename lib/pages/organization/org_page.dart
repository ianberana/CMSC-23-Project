// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donate/pages/organization/org_donationDetails.dart';
import 'package:elbi_donate/pages/organization/org_donationDrive.dart';
import 'package:elbi_donate/pages/organization/org_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
// import '../../providers/donation_provider.dart';
// import 'org_profile.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  @override
  Widget build(BuildContext context) {
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    String status = 'Pending';
    return Scaffold(
      appBar: AppBar(
        title: Text('Donations',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF008080),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to the desired color
        ),
      ),
      drawer: OrgDrawer(),
      body: Container(
        color: Color(0xFF008080),
        child: ListView(
          children: [
            DonationCard(),
            DonationCard(),
          ],
        ),
      ),
    );
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
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () async {
    //       // showDialog(
    //       //   context: context,
    //       //   builder: (BuildContext context) => TodoModal(
    //       //     type: 'Add',
    //       //     item: null,
    //       //   ),
    //       // );
    //       await context
    //           .read<DonationListProvider>()
    //           .updateStatus("LJoJUvfjpIBNNd3KFWPG", "completed");

    //       await context
    //           .read<DonationListProvider>()
    //           .updateDrive("LJoJUvfjpIBNNd3KFWPG", "LJoJUvfjpIBNNd3KFWPG");
    //     },
    //     child: const Icon(Icons.add_outlined),
    //   ),
    // );
  }

  // Drawer get drawer => Drawer(
  //         child: ListView(padding: EdgeInsets.zero, children: [
  //       const DrawerHeader(decoration: BoxDecoration(color: Colors.white),child: Text("Elbi Donate")),
  //       ListTile(
  //         title: const Text('Details'),
  //         onTap: () {
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => OrgDonationDetails()));
  //         },
  //       ),
  //       ListTile(
  //         title: const Text('Donation Drive'),
  //         onTap: () {
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => OrgDonationDrive()));
  //           // Navigator.pop(context);
  //           // Navigator.pushNamed(context, "/");
  //         },
  //       ),
  //       ListTile(
  //         title: const Text('Logout'),
  //         onTap: () {
  //           context.read<UserAuthProvider>().signOut();
  //           Navigator.pop(context);
  //         },
  //       ),
  //     ]));
}

// class DonationCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Magen Alarcon',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18.0,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Pending',
//                       style: TextStyle(
//                         color: Colors.teal,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.teal,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 8.0),
//             Row(
//               children: [
//                 Icon(
//                   Icons.access_time,
//                   size: 16.0,
//                 ),
//                 SizedBox(width: 4.0),
//                 Text('12-02-2020'),
//               ],
//             ),
//             SizedBox(height: 8.0),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF008080),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 ),
//                 child: Text('Link Donation', style: TextStyle(color: Colors.white),),
//               ),
//             ),
//           ],
//         ),
//       ),

//     );
//   }
// }

class DonationCard extends StatefulWidget {
  @override
  _DonationCardState createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  String status = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrgDonationDetails()),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Magen Alarcon',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16.0,
                          ),
                          SizedBox(width: 4.0),
                          Text('12-02-2020'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    children: [
                      DropdownButton<String>(
                        value: status,
                        items:
                            ['Pending', 'Accepted', 'Completed'].map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (newStatus) {
                          setState(() {
                            status = newStatus!;
                          });
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF008080),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                          ),
                          child: Text(
                            'Link Donation',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

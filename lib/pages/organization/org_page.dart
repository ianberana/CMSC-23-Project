// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/donation_provider.dart';
import 'org_profile.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  @override
  Widget build(BuildContext context) {
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: const Text("Organization Page"),
      ),
      body: Container(),
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
          await context
              .read<DonationListProvider>()
              .updateStatus("LJoJUvfjpIBNNd3KFWPG", "completed");

          await context
              .read<DonationListProvider>()
              .updateDrive("LJoJUvfjpIBNNd3KFWPG", "LJoJUvfjpIBNNd3KFWPG");
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
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

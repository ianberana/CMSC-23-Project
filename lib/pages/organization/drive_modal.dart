/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 
*/

import 'package:elbi_donate/models/drive_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:week7_networking_discussion/models/todo_model.dart';
// import 'package:week7_networking_discussion/providers/todo_provider.dart';

class DriveModal extends StatelessWidget {
  String type;
  int driveIndex;
  TextEditingController _formFieldController = TextEditingController();

  DriveModal({super.key, required this.type, required this.driveIndex});

  // Method to show the title of the modal depending on the functionality
  Text _buildTitle() {
    switch (type) {
      case 'Add':
        return const Text("Add new donation drive");
      case 'Edit':
        return const Text("Edit donation drive");
      case 'Delete':
        return const Text("Delete donation drive");
      default:
        return const Text("");
    }
  }

  // Method to build the content or body depending on the functionality
  Widget _buildContent(BuildContext context) {
    // Use context.read to get the last updated list of todos
    List<Drive> driveItems = context.read<DriveListProvider>().drive;

    switch (type) {
      case 'Delete':
        {
          return Text(
            "Are you sure you want to delete '${driveItems[driveIndex].name}'?",
          );
        }
      // Edit and add will have input field in them
      default:
        return TextField(
          controller: _formFieldController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: driveIndex != -1 ? driveItems[driveIndex].name : '',
          ),
        );
    }
  }

  TextButton _dialogAction(BuildContext context) {
    List<Drive> driveItems = context.read<DriveListProvider>().drive;

    return TextButton(
      onPressed: () {
        switch (type) {
          case 'Add':
            {
              // Instantiate a todo objeect to be inserted, default userID will be 1, the id will be the next id in the list
              Drive temp = Drive(
                id: '',
                name: '',
                description: '',
                contact: '',
                email: '',
                orgId: '',
              );

              context.read<DriveListProvider>().addDrive(temp);

              // Remove dialog after adding
              Navigator.of(context).pop();
              break;
            }
          case 'Edit':
            {
              context
                  .read<DriveListProvider>()
                  .editDrive(driveIndex, _formFieldController.text);

              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
          case 'Delete':
            {
              context
                  .read<DriveListProvider>()
                  .deleteDrive(driveItems[driveIndex].name);

              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
        }
      },
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: Text(type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(context),

      // Contains two buttons - add/edit/delete, and cancel
      actions: <Widget>[
        _dialogAction(context),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}

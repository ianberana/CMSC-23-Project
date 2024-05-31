import 'package:elbi_donate/models/drive_model.dart';
import 'package:elbi_donate/models/org_model.dart';
import 'package:elbi_donate/providers/drive_provider.dart';
import 'package:elbi_donate/providers/org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriveModal extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String type;
  final Drive? driveItem;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  DriveModal({super.key, required this.type, required this.driveItem});

  // Method to show the title of the modal depending on the functionality
  Text _buildTitle() {
    switch (type) {
      case 'Add':
        return const Text("Add new donation drive");
      case 'Edit':
        return const Text("Edit donation drive");
      case 'Delete':
        return const Text("Delete donation drive");
      case 'Link Donations':
        return const Text("Link donation to drive");
      default:
        return const Text("");
    }
  }

  // Method to build the content or body depending on the functionality
  Widget _buildContent(BuildContext context) {
    // Regular expression for email validation
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Regular expression for phone number validation
    final RegExp phoneRegex = RegExp(r'^\d{11}$');

    switch (type) {
      case 'Delete':
        {
          return Text(
            "Are you sure you want to delete '${driveItem!.name}'?",
          );
        }
      // Edit and add will have input field in them
      default:
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: "Enter organization drive name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    hintText: "Enter description",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contact no.',
                    hintText: "09XX-XXX-XXXX",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a contact number';
                    }
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Please enter a valid contact number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter a valid email',
                    hintText: "Enter Email Address",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email address";
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
    }
  }

  TextButton _dialogAction(BuildContext context) {
    return TextButton(
      onPressed: () {
        switch (type) {
          case 'Add':
            {
              Organization? org = context.watch<OrgListProvider>().currentOrg;
              Drive temp = Drive(
                id: '',
                name: _nameController.text,
                description: _descriptionController.text,
                contact: _contactController.text,
                email: _emailController.text,
                orgId: org!.id!,
                dateCreated: DateTime.now(),
              );
              if (_formKey.currentState!.validate()) {
                context.read<DriveListProvider>().addDrive(temp);

                // Remove dialog after adding
                Navigator.of(context).pop();
              }
              break;
            }
          case 'Edit':
            {
              if (driveItem != null) {
                Drive updatedDrive = Drive(
                  id: driveItem!.id,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  contact: _contactController.text,
                  email: _emailController.text,
                  orgId: driveItem!.orgId,
                  dateCreated: driveItem!
                      .dateCreated, // Update the date to the current date
                );
                context
                    .read<DriveListProvider>()
                    .editDrive(updatedDrive, driveItem!.id!);

                // Remove dialog after editing
                Navigator.of(context).pop();
              }
              break;
            }
          case 'Delete':
            {
              context.read<DriveListProvider>().deleteDrive(driveItem!.id!);

              // Remove dialog after deleting
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

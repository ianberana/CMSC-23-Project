import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/org_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/donor_provider.dart';
import '../../models/donor_model.dart';
import '../../models/org_model.dart';
import '../../models/user_model.dart';
import 'signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? address;
  String? contact;
  String? email;
  String? password;
  PlatformFile? proofOfLegitimacyFile;

  bool isOrganization = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController proofController = TextEditingController();

  bool validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (value.isEmpty || !regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> pickProofOfLegitimacyFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        proofOfLegitimacyFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Sign Up",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          TextButton(
              child: Text(
                "Login",
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 52, 199, 59)),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage()));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  nameField,
                  addressField,
                  contactField,
                  emailField,
                  passwordField,
                  organizationCheckbox,
                  if (isOrganization) proofOfLegitimacyField,
                  submitButton,
                ],
              ),
            )),
      ),
    );
  }

  Widget get nameField => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          controller: nameController,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[400])!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[200])!,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              label: Text("Name"),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              hintText: "Enter your name"),
          onSaved: (value) => setState(() => name = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your name";
            }
            return null;
          },
        ),
      );

  Widget get addressField => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          controller: addressController,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[400])!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[200])!,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              label: Text("Address"),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              hintText: "Enter your address"),
          onSaved: (value) => setState(() => address = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your address";
            }
            return null;
          },
        ),
      );

  Widget get contactField => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          controller: contactController,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[400])!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[200])!,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              label: Text("Contact Number"),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              hintText: "Enter your contact number"),
          onSaved: (value) => setState(() => contact = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your contact number";
            }
            return null;
          },
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          controller: emailController,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[400])!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[200])!,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              label: Text("Email"),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              hintText: "Enter your email"),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your email";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          controller: passwordController,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[400])!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[200])!,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              label: Text("Password"),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              hintText: "At least 6 characters"),
          obscureText: true,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a valid password";
            } else if (!validatePassword(value)) {
              return "Password must at least be 6 characters\nPassword must have an uppercase character\nPassword must have a lowercase character\nPassword must have a digit\nPassword must have a special character";
            }
            return null;
          },
        ),
      );

  Widget get organizationCheckbox => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: CheckboxListTile(
          title: Text(
            "Sign Up as an Organization",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: isOrganization,
          onChanged: (value) {
            setState(() {
              isOrganization = value ?? false;
            });
          },
        ),
      );

  Widget get proofOfLegitimacyField => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: pickProofOfLegitimacyFile,
              child: Text("Upload Proof of Legitimacy"),
            ),
            if (proofOfLegitimacyFile != null)
              Text(
                "Selected file: ${proofOfLegitimacyFile!.name}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      );

  Widget get submitButton => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(18)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 52, 199, 59))),
            onPressed: () async {
              if (_formKey.currentState!.validate() &&
                  proofOfLegitimacyFile != null) {
                _formKey.currentState!.save();

                if (isOrganization) {
                  Organization org = Organization(
                      name: nameController.text,
                      address: addressController.text,
                      contact: contactController.text,
                      email: emailController.text,
                      proof: proofOfLegitimacyFile!.path!);

                  await context
                      .read<OrgListProvider>()
                      .addOrganization(org, proofOfLegitimacyFile!);
                  // String url = await context
                  //     .read<ProofProvider>()
                  //     .uploadProof(proofOfLegitimacyFile!, id);
                  // await context.read<OrgListProvider>().addProof(id, url);
                } else {
                  Donor donor = Donor(
                      name: nameController.text,
                      address: addressController.text,
                      contact: contactController.text,
                      email: emailController.text);
                  await context.read<DonorListProvider>().addDonor(donor);
                }

                User user = User(
                    email: emailController.text,
                    type: isOrganization ? "organization" : "user");
                await context.read<UserProvider>().addUser(user);

                await context
                    .read<UserAuthProvider>()
                    .authService
                    .signUp(email!, password!);

                // check if the widget hasn't been disposed of after an asynchronous action
                if (mounted) Navigator.pop(context);
              }
            },
            child: Text(
              "Sign Up",
              style: Theme.of(context).textTheme.displaySmall,
            )),
      );
}

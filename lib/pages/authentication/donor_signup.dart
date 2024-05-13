import 'package:elbi_donate/pages/authentication/organization_signup.dart';
import 'package:elbi_donate/pages/authentication/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';

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
  String? username;
  String? password;

  int _selectedPage = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // bool validateEmail(String? value) {
  //   const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
  //       r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
  //       r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
  //       r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
  //       r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
  //       r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
  //       r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  //   final regex = RegExp(pattern);

  //   return value!.isEmpty || !regex.hasMatch(value) ? false : true;
  // }

  bool validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

    if (value.isEmpty || !regex.hasMatch(value)) {
      return false;
    } else {
      return true;
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
                  heading,
                  nameField,
                  addressField,
                  contactField,
                  usernameField,
                  passwordField,
                  submitButton,
                ],
              ),
            )),
      ),
    );
  }

  Widget get heading => Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            Expanded(
              child: RadioListTile<int>(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Donor',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 0,
                groupValue: _selectedPage,
                onChanged: (value) {
                  setState(() {
                    _selectedPage = value!;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<int>(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Organization',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 1,
                groupValue: _selectedPage,
                onChanged: (value) {
                  setState(() {
                    _selectedPage = value!;
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrgSignUpPage()));
                  });
                },
              ),
            ),
          ],
        ),
      );

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
              label: Text("Name of Donor"),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              hintText: "Enter your name"),
          onSaved: (value) => setState(() => name = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your first name";
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

  Widget get usernameField => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          controller: usernameController,
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
              label: Text("Username"),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              hintText: "Enter your username"),
          onSaved: (value) => setState(() => username = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your username";
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
              return "Password must at least be 6 characters\nPassword must have an uppercase character\nPassword must have an lowercase character\nPassword must have a digit\nPassword must have a special character";
            }
            return null;
          },
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
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                User user = User(
                    name: nameController.text,
                    address: addressController.text,
                    contact: contactController.text,
                    username: usernameController.text);
                await context.read<UserListProvider>().addUser(user);

                await context
                    .read<UserAuthProvider>()
                    .authService
                    .signUp(username!, password!);

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

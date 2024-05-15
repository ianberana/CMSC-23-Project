import 'package:elbi_donate/pages/authentication/donor_signup.dart';
import 'package:elbi_donate/pages/authentication/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class OrgSignUpPage extends StatefulWidget {
  const OrgSignUpPage({super.key});

  @override
  State<OrgSignUpPage> createState() => _OrgSignUpState();
}

class _OrgSignUpState extends State<OrgSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? address;
  String? contact;
  String? username;
  String? password;

  int _selectedPage = 1;

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
                style: Theme.of(context).textTheme.titleSmall,
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
                    // Add your text style here
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 0,
                groupValue: _selectedPage,
                onChanged: (value) {
                  setState(() {
                    _selectedPage = value!;
                    Navigator.pop(context);
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
                    // Add your text style here
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 1,
                groupValue: _selectedPage,
                onChanged: (value) {
                  setState(() {
                    _selectedPage = value!;
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
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Name"),
              hintText: "Ex. UPLB Web Development Society"),
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
          controller: nameController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Address"),
              hintText: "Ex. UPLB Web Development Society"),
          onSaved: (value) => setState(() => name = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your first name";
            }
            return null;
          },
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'signup.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool showSignInErrorMessage = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void setError(bool error) {
    setState(() {
      showSignInErrorMessage = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Login",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          TextButton(
              child: Text(
                "Sign up",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 150, horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // heading,
                  emailField,
                  passwordField,
                  showSignInErrorMessage ? signInErrorMessage : Container(),
                  submitButton,
                  // signUpButton
                ],
              ),
            )),
      ),
    );
  }

  // Widget get heading => const Padding(
  //       padding: EdgeInsets.only(bottom: 30),
  //       child: Text(
  //         "Sign In",
  //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  //       ),
  //     );

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
              hintText: "juandelacruz09@gmail.com"),
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
              hintText: "******"),
          obscureText: true,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your password";
            }
            return null;
          },
        ),
      );

  Widget get signInErrorMessage => const Center(
        child: Text(
          "Invalid email or password",
          style: TextStyle(color: Colors.red),
        ),
      );

  Widget get submitButton => Padding(
      padding: const EdgeInsets.only(top: 60),
      child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(18)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 172, 225, 175))),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              bool error = await context.read<UserAuthProvider>().signIn(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

              setError(error);
            }
          },
          child: Text(
            "Login",
            style: Theme.of(context).textTheme.displaySmall,
          )));

  // Widget get signUpButton => Padding(
  //       padding: const EdgeInsets.all(30),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Text("No account yet?"),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => const SignUpPage()));
  //               },
  //               child: const Text("Sign Up"))
  //         ],
  //       ),
  //     );
}

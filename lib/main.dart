/*
  Created by: ALARCON, BERANA, PALMA
  Date: updated May 27, 2024
  Description: Elbi Donation System 
*/
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/org_provider.dart';
import 'providers/type_provider.dart';
import 'providers/user_provider.dart';
import 'pages/authentication/authenticate.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
        ChangeNotifierProvider(create: ((context) => UserTypeProvider())),
        ChangeNotifierProvider(create: ((context) => UserListProvider())),
        ChangeNotifierProvider(create: ((context) => OrgListProvider()))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Elbi Donate',
        initialRoute: '/',
        routes: {
          '/': (context) => Authenticate(),
        },
        theme: ThemeData(
            textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(
            fontSize: 35,
            fontWeight: FontWeight.w600,
          ).copyWith(color: Colors.black),
          titleSmall: GoogleFonts.inter(
            fontSize: 18,
            // fontWeight: FontWeight.w500,
          ).copyWith(color: Color.fromARGB(255, 172, 225, 175)),
          displaySmall: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ).copyWith(color: Colors.white),
          labelSmall: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ).copyWith(color: Colors.grey[400]),
        )));
  }
}

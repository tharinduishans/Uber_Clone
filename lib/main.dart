import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myuber_rider_app/AllScreens/LoginScreen.dart';
import 'package:myuber_rider_app/AllScreens/mainscreen.dart';
import 'package:myuber_rider_app/AllScreens/RegistrationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myuber_rider_app/DataHandler/appData.dart';
import 'package:provider/provider.dart';
//import 'dart:js';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Taxi Rider App',
        theme: ThemeData(
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: MainScreen.idScreen,
        routes:
        {
          RegistrationScreen.idScreen: (context) => RegistrationScreen (),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

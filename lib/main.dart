import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dashboard.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   StreamBuilder(
          stream: auth.onAuthStateChanged,
          builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              print("auth state ${snapshot.data}");
              return DashBoardView(title: "Google SignIn",auth: auth,googleSignIn: googleSignIn,user: snapshot.data,);
            } else {
              print("auth state $snapshot");
              return MyHomePage(title: "Google SignIn",auth: auth,googleSignIn: googleSignIn,user: user,);
            }
          }),
    );
  }
}


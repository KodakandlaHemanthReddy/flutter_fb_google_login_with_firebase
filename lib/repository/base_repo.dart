
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseRepository{

  FirebaseAuth get fireBaseAuth;
  GoogleSignIn get googleSignIn;
  FirebaseUser get loggedInUser;
  void signInWithEmail(String email,String password,BuildContext context);
  void handleSignIn(BuildContext context);
  void signUpWithEmail(String email,String password,BuildContext context);
  void sendSignInWithEmailLink(String email);
  routeHandler(BuildContext context);
  void signOut(BuildContext context);
  void userData();
}
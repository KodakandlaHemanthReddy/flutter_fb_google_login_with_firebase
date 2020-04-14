
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseRepository{

  FirebaseAuth get fireBaseAuth;
  GoogleSignIn get googleSignIn;
  FirebaseUser get loggedInUser;
  void signInWithEmail(String email,String password);
  void handleSignIn();
  void signUpWithEmail(String email,String password);
  void sendSignInWithEmailLink(String email);
  routeHandler(BuildContext context);
  void signOut();
}
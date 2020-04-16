
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttergooglesigninapp/repository/base_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;

abstract class LoginRepository implements BaseRepository{

  FirebaseAuth get fireBaseAuth;
  GoogleSignIn get googleSignIn;
  FirebaseUser get loggedInUser;
  void signInWithEmail(String email,String password,BuildContext context);
  Future<FirebaseUser> handleSignIn(BuildContext context);
  void signUpWithEmail(String email,String password,BuildContext context);
  void sendSignInWithEmailLink(String email);
  routeHandler(BuildContext context);
  void login(simpleAuth.AuthenticatedApi api);

}
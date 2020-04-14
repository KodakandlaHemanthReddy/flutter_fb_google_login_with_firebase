

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergooglesigninapp/ui/dashboard_view.dart';
import 'package:fluttergooglesigninapp/ui/login_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'base_repo.dart';

class BaseRepositoryImpl implements BaseRepository{


  FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseUser user;
  GoogleSignIn googleSignInInstance = new GoogleSignIn();

  @override
  // TODO: implement fireBaseAuth
  FirebaseAuth get fireBaseAuth => auth;

  @override
  // TODO: implement googleSignIn
  GoogleSignIn get googleSignIn => googleSignInInstance;
  FirebaseUser get loggedInUser => user;

  @override
    signInWithEmail(String email, String password) async {
      var result = await auth.signInWithEmailAndPassword(email: email, password: password);
      print("email auth ${result.user.photoUrl}");
      user = result.user;
    }

  @override
  handleSignIn() async
  {
    print("entered login");
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    print("sign in");
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    print("Success print");
    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print("signed in");
    AuthResult result = (await auth.signInWithCredential(credential));
    print("login");
    user = result.user;
  }

  @override
  signUpWithEmail(String email, String password) async {
    var result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    print("signup email auth ${result.user.toString()}");
    user = result.user;
  }
  @override
  sendSignInWithEmailLink(String email) async {
    print("email sign in link");
    return auth.sendSignInWithEmailLink(
        email: email,
        url: "https://fluttergooglesigninapp.page.link",
        handleCodeInApp: true,
        iOSBundleID: 'com.firebasebootcamp.fluttergooglesigninapp',
        androidPackageName: 'com.firebasebootcamp.fluttergooglesigninapp',
        androidInstallIfNotAvailable: true,
        androidMinimumVersion: "21");
  }

  @override
  routeHandler(BuildContext context){
    fireBaseAuth.onAuthStateChanged.listen((onData){
      if(onData != null){
        Navigator.pushReplacement(context,  MaterialPageRoute(builder: (BuildContext context) => DashBoardView()));
      }else{
        Navigator.pushReplacement(context,  MaterialPageRoute(builder: (BuildContext context) => LoginView()));
      }
    });
  }
  @override
  void signOut() {
    // TODO: implement signOut
    auth.signOut().then((response) {
      googleSignInInstance.signOut();
    });
  }
}
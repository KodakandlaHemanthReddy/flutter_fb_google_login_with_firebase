
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergooglesigninapp/repository/dashboard_repo.dart';
import 'package:fluttergooglesigninapp/repository/login_repo.dart';
import 'package:fluttergooglesigninapp/repository/login_repo_impl.dart';
import 'package:fluttergooglesigninapp/utilities/shared_prences.dart';

class DashBoardRepositoryImpl implements DashBoardRepository{

  FirebaseUser loggedInUser;

  @override
  Future<FirebaseUser> userData() async{
    print("user data called");
    loggedInUser = await LoginRepositoryImpl().auth.currentUser();
    print("user data $loggedInUser");
    return loggedInUser;
  }

  @override
  void signOut(BuildContext context) {
    // TODO: implement signOut
    LoginRepositoryImpl().auth.signOut().then((response) {
      LoginRepositoryImpl().googleSignInInstance.signOut();
      SharedPreference().delete_prefrences("loggedUser");
      LoginRepositoryImpl().routeHandler(context);
    });
  }
}
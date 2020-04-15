

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttergooglesigninapp/bloc/base_bloc.dart';
import 'package:fluttergooglesigninapp/repository/dashboard_repo.dart';
import 'package:fluttergooglesigninapp/repository/dashboard_repo_impl.dart';

class DashBoardBloc implements BaseBloc{
  DashBoardRepository _dashBoardRepository;

  @override
  void init() {
    // TODO: implement init
    _dashBoardRepository = DashBoardRepositoryImpl();
    getUserData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  FirebaseUser loggedUser;

  getUserData() async{
   loggedUser = await _dashBoardRepository.userData();
  }
  signOut(BuildContext context){
    _dashBoardRepository.signOut(context);
  }
}
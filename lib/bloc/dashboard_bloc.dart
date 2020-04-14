

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttergooglesigninapp/bloc/base_bloc.dart';
import 'package:fluttergooglesigninapp/repository/base_repo.dart';
import 'package:fluttergooglesigninapp/repository/base_repo_impl.dart';

class DashBoardBloc implements BaseBloc{
  BaseRepository _baseRepository;

  @override
  void init() {
    // TODO: implement init
    _baseRepository = BaseRepositoryImpl();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  FirebaseUser loggedUser;

  getUserData(){
//    _baseRepository.userData();
  }
  signOut(BuildContext context){
    _baseRepository.signOut(context);
  }
}
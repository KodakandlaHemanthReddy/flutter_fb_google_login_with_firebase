

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergooglesigninapp/bloc/base_bloc.dart';
import 'package:fluttergooglesigninapp/repository/base_repo.dart';
import 'package:fluttergooglesigninapp/repository/base_repo_impl.dart';
import 'package:fluttergooglesigninapp/ui/dashboard_view.dart';
import 'package:fluttergooglesigninapp/ui/login_view.dart';

class SplashScreenBloc implements BaseBloc{

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

  startTimer(BuildContext context){
    Timer(Duration(seconds: 2), (){
      _baseRepository.fireBaseAuth.onAuthStateChanged.listen((onData){
        if(onData != null){
          Navigator.pushReplacement(context,  MaterialPageRoute(builder: (BuildContext context) => DashBoardView()));
        }else{
          Navigator.pushReplacement(context,  MaterialPageRoute(builder: (BuildContext context) => LoginView()));
        }
    });
  });
}
}
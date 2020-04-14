
import 'package:flutter/material.dart';
import 'package:fluttergooglesigninapp/bloc/base_bloc.dart';
import 'package:fluttergooglesigninapp/repository/base_repo.dart';
import 'package:fluttergooglesigninapp/repository/base_repo_impl.dart';

class LoginBloc implements BaseBloc{

  BaseRepository _baseRepository;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isTapped = false;

  @override
  void init() {
    // TODO: implement init
    _baseRepository = BaseRepositoryImpl();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  signInWithEmail(String email,String password){
    _baseRepository.signInWithEmail(email,password);
  }

  signUpWithEmail(String email,String password){
    _baseRepository.signUpWithEmail(email, password);
  }

  sendEmailLink(String email){
    _baseRepository.sendSignInWithEmailLink(email);
  }

  handleSignIn(){
    _baseRepository.handleSignIn();
  }

}
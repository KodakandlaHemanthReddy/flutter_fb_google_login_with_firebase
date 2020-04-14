
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

  signInWithEmail(String email,String password,BuildContext context){
    _baseRepository.signInWithEmail(email,password,context);
  }

  signUpWithEmail(String email,String password,BuildContext context){
    _baseRepository.signUpWithEmail(email, password,context);
  }

  sendEmailLink(String email){
    _baseRepository.sendSignInWithEmailLink(email);
  }

  handleSignIn(BuildContext context){
    _baseRepository.handleSignIn(context);
  }

}
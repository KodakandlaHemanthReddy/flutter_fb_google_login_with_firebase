

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class DashBoardRepository{
  void signOut(BuildContext context);
  Future<FirebaseUser> userData();
}
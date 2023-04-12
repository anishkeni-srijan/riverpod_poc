import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginState{logininit,loginsuccessful,loginfailed,loading}

class loginValidator {
  Future <LoginState> validate(uname, pass, context) async {
    List _user = [];
    final String response = await DefaultAssetBundle.of(context).loadString(
        "assets/response.json");
    final data = jsonDecode(response);
    _user = data['User'];
    //If user does not exist!
    if (_user[0]['username'] != uname && _user[0]['password'] != pass) {
      return LoginState.loginfailed;
    }
    //user exists
    else {
      //login successful
      if (_user[0]['username'] == uname && _user[0]['password'] == pass) {
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('uname', uname);
        return LoginState.loginsuccessful;
      }
      // incorrect credentials
      else {
        if (_user[0]['username'] != uname) {

          return LoginState.loginfailed;
        }
        else {
          return LoginState.loginfailed;
        }
      }
    }
  }
}
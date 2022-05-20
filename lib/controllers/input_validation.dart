import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_update_3_0_0_app/utils/widgets/alert_helper.dart';

class InputValidator{
  // this is the validation for email and password fields
  bool isLoginValidated(BuildContext context,String email,String password) {
    if (email.isEmpty || password.isEmpty) {
      Logger().i("Field cannot be ampty");
      AlertHelper().showAlert(context, DialogType.WARNING, 'Empty Fields',
          'Fields cannot be empty', () {});
      return false;
    } else {
      return true;
    }
  }

  // when user in registration page, then this method wil execute
  bool isREgistrationValidated(BuildContext context,String email, String password,String contact,String name) {
    if (email.isEmpty ||
        password.isEmpty ||
        contact.isEmpty ||
        name.isEmpty) {
      Logger().i("Field cannot be ampty");
      AlertHelper().showAlert(context, DialogType.WARNING, 'Empty Fields',
          'Fields cannot be empty', () {});
      return false;
    } else if (!email.contains('@')) {
      AlertHelper().showAlert(context, DialogType.WARNING, 'Invalid email',
          'email must have "@" ', () {});
      return false;
    } else if (password.length < 6) {
      AlertHelper().showAlert(context, DialogType.WARNING, 'Short Passwrod',
          'Password need minimum 6 chracters', () {});
      return false;
    } else {
      return true;
    }
  }
}
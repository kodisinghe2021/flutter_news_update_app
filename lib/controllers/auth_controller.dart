import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:news_update_3_0_0_app/utils/util_functions.dart';
import 'package:news_update_3_0_0_app/utils/widgets/alert_helper.dart';
import 'package:news_update_3_0_0_app/views/home_screen/home_screen.dart';
import 'package:news_update_3_0_0_app/views/login_screens/login_screen.dart';

class AuthController {
  //registration page firebase instance
  FirebaseAuth mAuth = FirebaseAuth.instance;

  // firebsae dbd instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create user in firebase
  Future<void> registerUser({
    required String name,
    required String contact,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // register user email with password
      UserCredential userCredential = await mAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //if user registration is success, other details save using this method
      if (userCredential.user!.uid != null) {
        await saveUserDate(
            uid: userCredential.user!.uid,
            name: name,
            contact: contact,
            email: email,
            context: context);
      }
    } on FirebaseAuthException catch (e) {
// if user registration is failed then this alert box will apear
      AlertHelper().showAlert(
          context, DialogType.ERROR, 'Registration failed', e.code, () {});
    } catch (e) {
      Logger().e(e);
    }
  }

  // save user data
  Future<void> saveUserDate({
    required String uid,
    required String name,
    required String contact,
    required String email,
    required BuildContext context,
  }) async {
    try {
      firestore
          .collection('users')
          .doc(uid)
          .set({
            'uid': uid,
            'fullname': name,
            'contact': contact,
            'email': email
          })
          .then((value) => AlertHelper().showAlert(context, DialogType.SUCCES,
              "Registration Success", "You data has been  stored", () {}))
          .catchError((error) => Logger().e("Registration Failed.. : $error"));
    } catch (e) {
      Logger().e(e);
    }
  } //saveUserDate

// this method for login user
  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // this code from google signin with email and password
      // if user login is success then credintial varible has been catched email of user
      final credential = await mAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // here check that email is null or not, if it is not null its mean login is success
      if (credential.user!.email != null) {
        AlertHelper().showAlert(
            context, DialogType.SUCCES, 'Success', 'Successfully login', () {});
       // Navigator.pop(context);
      }
      // if login is fieild then here catch the error, this line catch if user email, not in DB
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AlertHelper()
            .showAlert(context, DialogType.ERROR, 'Error', e.code, () {});
        // here check user password is incorrect
      } else if (e.code == 'wrong-password') {
        AlertHelper()
            .showAlert(context, DialogType.ERROR, 'Error', e.code, () {});
      }
    } catch (e) {
      AlertHelper()
          .showAlert(context, DialogType.ERROR, 'Error', e.toString(), () {});
    }
  }

  //checking if user is logged or not when run
  Future<void> initializeUser(BuildContext context) async {
    mAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        Logger().i("User is currenlty logged");
        UtilFunctions.navigator(context, const HomeScreen());
      } else if (user == null) {
        Logger().i("User is currenlty sing out");
        UtilFunctions.navigator(context, LoginScreen());
      }
    });
  }

  // sign out user
  Future<void> userSignOut() async {
    await FirebaseAuth.instance.signOut();
  }
} // AuthController

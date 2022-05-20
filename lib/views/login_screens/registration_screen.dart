import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:news_update_3_0_0_app/controllers/auth_controller.dart';
import 'package:news_update_3_0_0_app/controllers/input_validation.dart';
import 'package:news_update_3_0_0_app/utils/util_functions.dart';
import 'package:news_update_3_0_0_app/utils/widgets/alert_helper.dart';
import 'package:news_update_3_0_0_app/utils/widgets/custom_elevated_button.dart';
import 'package:news_update_3_0_0_app/utils/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_update_3_0_0_app/views/login_screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //registration page firebase instance
  FirebaseAuth mAuth = FirebaseAuth.instance;

  // firebsae dbd instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // variable for catch iputs
  final _name = TextEditingController();

  final _contact = TextEditingController();

  final _email = TextEditingController();

  final _password = TextEditingController();

  bool is_loading = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Registration",
                    style: TextStyle(fontSize: 50, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: CustomTextField(
                      lable: 'Full Name',
                      controller: _name,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: CustomTextField(
                      lable: 'Contact',
                      controller: _contact,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: CustomTextField(
                      lable: 'Email',
                      controller: _email,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: CustomTextField(
                      lable: 'Password',
                      controller: _password,
                      is_obsecure: true,
                    ),
                  ),
                  const SizedBox(height: 100.0),
                  CustomElevatedButton(
                    lable: 'Register',
                    is_loading: is_loading,
                    onTap: () async {
                      if (InputValidator().isREgistrationValidated(
                          context,
                          _email.text,
                          _password.text,
                          _contact.text,
                          _name.text)) {
                        // set state  to visible loading spinner
                        setState(() {
                          is_loading = true;
                        });
                        // call to user registration function
                        await AuthController().registerUser(
                            name: _name.text,
                            contact: _contact.text,
                            email: _email.text,
                            password: _password.text,
                            context: context);
                        // set state  to hide loading spinner
                        setState(() {
                          is_loading = false;
                        });

                        // if succesfully created user then this alert will shown
                        AlertHelper().showAlert(context, DialogType.SUCCES,
                            'Success', 'Successfully login', () {});
                        _email.clear();
                        _password.clear();
                        _contact.clear();
                        _name.clear();
                        UtilFunctions.navigator(context, LoginScreen());
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      _email.clear();
                      _password.clear();
                      _contact.clear();
                      _name.clear();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Have Account? Login Here",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_update_3_0_0_app/controllers/auth_controller.dart';
import 'package:news_update_3_0_0_app/controllers/input_validation.dart';
import 'package:news_update_3_0_0_app/utils/util_functions.dart';
import 'package:news_update_3_0_0_app/utils/widgets/alert_helper.dart';
import 'package:news_update_3_0_0_app/utils/widgets/custom_elevated_button.dart';
import 'package:news_update_3_0_0_app/utils/widgets/custom_text_field.dart';
import 'package:news_update_3_0_0_app/views/home_screen/home_screen.dart';
import 'package:news_update_3_0_0_app/views/login_screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  // firebase auth instance
  FirebaseAuth mAuth = FirebaseAuth.instance;
// this is for spinner state controller
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
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 50, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: CustomTextField(
                      lable: 'User Name',
                      controller: _email,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: CustomTextField(
                      lable: 'Password',
                      controller: _password,
                      is_obsecure: true,
                    ),
                  ),
                  const SizedBox(height: 100.0),
                  CustomElevatedButton(
                    lable: 'Login',
                    is_loading: is_loading,
                    onTap: () async {
                      if (InputValidator().isLoginValidated(context,_email.text,_password.text)) {
                        //the state if start here
                        //is_loading variable true, now spinner will apeare,
                        setState(() {
                          is_loading = true;
                        });
                        // when user click on Login button this method will execute
                        await AuthController().loginUser(
                            email: _email.text,
                            password: _password.text,
                            context: context);
                        //the state if start here
                        //is_loading variable false, now spinner will disapeare,
                        setState(() {
                          is_loading = false;
                        });
                        _email.clear();
                        _password.clear();
                       // UtilFunctions.navigator(context, HomeScreen());
                      } else {
                        AlertHelper().showAlert(context, DialogType.WARNING,
                            "Empty Fields", "Fields cannot be empty", () {});
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      _email.clear();
                      _password.clear();
                      UtilFunctions.navigator(context, RegistrationScreen());
                    },
                    child: const Text(
                      "Not Account? Register Here",
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

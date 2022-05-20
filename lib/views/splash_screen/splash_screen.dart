import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:news_update_3_0_0_app/controllers/auth_controller.dart';
import 'package:news_update_3_0_0_app/utils/util_functions.dart';
import 'package:news_update_3_0_0_app/views/login_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//this method for function exetuce with dalay
  @override
  void initState() {
    navigateToLogin();
    super.initState();
  }

// this function for dalay
  void navigateToLogin() {
    Future.delayed(const Duration(milliseconds: 4000), () {
      UtilFunctions.navigator(context, LoginScreen());
      AuthController().initializeUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BounceInDown(
            duration: const Duration(milliseconds: 3000),
            from: 90,
            child: const Text(
              "News App",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

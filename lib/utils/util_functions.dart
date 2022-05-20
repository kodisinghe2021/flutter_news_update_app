
import 'package:flutter/material.dart';

class UtilFunctions{
  static void navigator(BuildContext context, Widget page){
 Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
  }
}
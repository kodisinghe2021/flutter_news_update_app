import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class AlertHelper {
  Future<dynamic> showAlert(BuildContext context, DialogType type, String title,
      String desc, Function ontap) async {
    return (AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.SCALE,
      title: title,
      desc: desc,
      btnOkOnPress: ontap(),
    ).show());
  }
}

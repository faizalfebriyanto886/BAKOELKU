import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget? CustomAlertDialogWarning({
  required String title,
  required String subTitle,
  required BuildContext context,
}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title, 
      message: subTitle, 
      contentType: ContentType.warning
    )
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  return null;
}

// ignore: non_constant_identifier_names
Widget? CustomAlertDialogSuccess({
  required String title,
  required String subTitle,
  required BuildContext context,
}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title, 
      message: subTitle, 
      contentType: ContentType.success
    )
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  return null;
}

// ignore: non_constant_identifier_names
Widget? CustomAlertDialogHelp({
  required String title,
  required String subTitle,
  required BuildContext context,
}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title, 
      message: subTitle, 
      contentType: ContentType.help
    )
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  return null;
}
import 'package:bakoelku/reusable_widget/alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
      );
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        CustomAlertDialogWarning(
          title: "Ooops", 
          subTitle: "Email dan password anda tidak cocok", 
          context: context
        );
      } else if (err.code == 'wrong-password') {
        CustomAlertDialogWarning(
          title: "Ooops", 
          subTitle: "Password anda salah...", 
          context: context
        );
      } else if (err.code == 'user-not-found' && err.code == "unknown") {
        CustomAlertDialogWarning(
          title: "Ooops", 
          subTitle: "Akun tidak ditemukan", 
          context: context
        );
      } else if (err.code == "network-request-failed") {
        CustomAlertDialogWarning(
          title: "Ooops", 
          subTitle: "Terjadi kesalahan pada koneksi anda", 
          context: context
        );
      } else {
        CustomAlertDialogWarning(
          title: "Ooops", 
          subTitle: "Akun tidak ditemukan", 
          context: context
        );
      }
      // ignore: avoid_print
      print("error :  ${err.code}");
    }
    
  }
}
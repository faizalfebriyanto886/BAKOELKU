import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Ooops!", 
            message: "Email dan password anda tidak cocok", 
            contentType: ContentType.warning
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (err.code == 'wrong-password') {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Ooops!", 
            message: "Password anda salah...", 
            contentType: ContentType.warning
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (err.code == 'user-not-found' && err.code == "unknown") {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Ooops!", 
            message: "Akun tidak ditemukan", 
            contentType: ContentType.warning
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (err.code == "network-request-failed") {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Ooops!", 
            message: "Terjadi kesalahan pada koneksi anda", 
            contentType: ContentType.warning
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      print("error :  ${err.code}");
    }
    
  }
}
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final noTelpController = TextEditingController();
  CollectionReference userData = FirebaseFirestore.instance.collection("auth");

  registrasiUser(BuildContext context) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    ).then((value) {
      userData.add({
        'email': emailController.text,
        'name': usernameController.text,
        'no_telp': noTelpController.text,
        'uid': value.user!.uid,
      }).then((value) {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Success", 
            message: "Email dan password berhasil terdaftar", 
            contentType: ContentType.success
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }).catchError((error) {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: "Maaf", 
            message: "Email dan password tidak berhasil terdaftar, mohon cek kembali", 
            contentType: ContentType.warning
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    });
    
  }
}
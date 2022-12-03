import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bakoelku/reusable_widget/alert_widget.dart';
import 'package:bakoelku/screen/main_page/view/main_page_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final noTelpController = TextEditingController();
  final alamatController = TextEditingController();
  final roleController = ''.obs;

  clearRegisterData() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    noTelpController.clear();
    alamatController.clear();
    roleController.value = '';
  }
  
  CollectionReference userData = FirebaseFirestore.instance.collection("auth");

  registrasiUser(BuildContext context) {
    if (
      usernameController.text.isNotEmpty 
      && emailController.text.isNotEmpty 
      && passwordController.text.isNotEmpty 
      && noTelpController.text.isNotEmpty
      && alamatController.text.isNotEmpty
      && roleController.value.isNotEmpty
    ) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
      ).then((value) {
        userData.add({
          'email': emailController.text,
          'name': usernameController.text,
          'no_telp': double.parse(noTelpController.text),
          'uid': value.user!.uid,
          'alamat': alamatController.text,
          'role': roleController.value
        }).then((value) {
          clearRegisterData();
          CustomAlertDialogSuccess(
            title: "Berhasil", 
            subTitle: "Email dan password berhasil terdaftar", 
            context: context
          );
          Timer(const Duration(seconds: 4), () => Get.back());
        }).catchError((error) {
          CustomAlertDialogWarning(
            title: "Maaf", 
            subTitle: "Email dan password tidak berhasil terdaftar, mohon cek kembali", 
            context: context
          );
        });
      });
    } else {
      CustomAlertDialogWarning(
        title: "Oops!", 
        subTitle: "terjadi kesalahan, Silahkan cek kembali", 
        context: context
      );
    }
  }
}
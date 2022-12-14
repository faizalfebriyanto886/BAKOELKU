import 'dart:async';
import 'package:bakoelku/reusable_widget/alert_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  registrasiUser(BuildContext context) async {
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
      ).then((value) async {
        Position posisi = await getGeoLocationPosition();
        userData.doc(value.user?.uid).set({
          'email': emailController.text,
          'name': usernameController.text,
          'no_telp': double.parse(noTelpController.text),
          'uid': value.user!.uid,
          'alamat': alamatController.text,
          'role': roleController.value,
          'latlong': GeoPoint(posisi.latitude, posisi.longitude)
        }).then((value) {
          clearRegisterData();
          CustomAlertDialogSuccess(
            title: "Berhasil", 
            subTitle: "Email dan password berhasil terdaftar", 
            context: context
          );
          Timer(const Duration(seconds: 3), () => Get.back());
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

   Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
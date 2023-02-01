import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:bakoelku/reusable_widget/alert_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final noTelpController = TextEditingController();
  final alamatController = TextEditingController();
  final namaGerobakController = TextEditingController();
  final namaMenuController = TextEditingController();
  final hargaMenuController = TextEditingController();
  final roleController = ''.obs;
  final validationRole = false.obs;
  final ImagePicker picker = ImagePicker();
  File? urlImages;
  String urlImageStorage = '';
  TimeOfDay timeBuka = TimeOfDay.now();
  TimeOfDay timeTutup = TimeOfDay.now();

  clearRegisterData() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    noTelpController.clear();
    alamatController.clear();
    roleController.value = '';
  }
  
  CollectionReference userData = FirebaseFirestore.instance.collection("auth");

  registrasiUserPedagang(BuildContext context) async {
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
          'latlong': GeoPoint(posisi.latitude, posisi.longitude),
          'nama_gerobak': namaGerobakController.text,
          'foto_gerobak': FieldValue.arrayUnion([
            urlImageStorage
          ]),
          'jam_buka': timeBuka.format(context).toString(),
          'jam_tutup': timeTutup.format(context).toString(),
          'menu': [{
            "harga": int.parse(hargaMenuController.text),
            "nama": namaMenuController.text,
          }]
        }).then((value) {
          clearRegisterData();
          CustomAlertDialogSuccess(
            title: "Berhasil", 
            subTitle: "Email dan password berhasil terdaftar", 
            context: context
          );
          Timer(const Duration(seconds: 3), () {
            Get.back();
            Get.back();
            update();
          });
          update();
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

  registrasiUserPembeli(BuildContext context) async {
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
          'latlong': GeoPoint(posisi.latitude, posisi.longitude),
          'nama_gerobak': namaGerobakController.text,
          'foto_gerobak': FieldValue.arrayUnion([
            urlImageStorage
          ])
        }).then((value) {
          clearRegisterData();
          CustomAlertDialogSuccess(
            title: "Berhasil", 
            subTitle: "Email dan password berhasil terdaftar", 
            context: context
          );
          Timer(const Duration(seconds: 3), () {
            Get.back();
          });
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

  Future uploadImageGallery(BuildContext context) async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      urlImages = File(pickerFile.path);
      CustomAlertDialogSuccess(
        title: "Success", 
        subTitle: "Gambar Berhasil ditambahkan", 
        context: context
      );

      update();
      
    } else {
      // ignore: avoid_print
      print("error Gallery");
    }
    update();
  }

  Future uploadToStorage(String namaPedagang, String namaGerobak, BuildContext context) async {
    var rng = Random();
    var angka = List.generate(1, (_) => rng.nextInt(10000));
    var destination = 'Image_gerobak/$namaPedagang';

    try {
      final ref = FirebaseStorage.instance
          .ref(destination)
          .child('$namaGerobak $angka/');
      await ref.putFile(urlImages!);
      
      String urlDownload = await ref.getDownloadURL();
      // urlDownload == urlImageStorage;
      urlImageStorage = urlDownload;
      
      // FirebaseFirestore.instance.collection('auth').doc(uid).update({
      //   'foto_gerobak': FieldValue.arrayUnion([
      //     urlDownload,
      //   ])
      // });
      CustomAlertDialogSuccess(
        title: "Success", 
        subTitle: "Gambar Berhasil diupload", 
        context: context
      );
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void selectTimeBuka(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: timeBuka,
    );
    if (newTime != null) {
      timeBuka = newTime;
      update();
    }
    update();
  }

  void selectTimeTutup(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context, 
      initialTime: timeTutup,
    );

    if (newTime != null) {
      timeTutup = newTime;
      update();
    }
    update();
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
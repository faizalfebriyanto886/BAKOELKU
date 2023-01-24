import 'dart:io';
import 'dart:math';

import 'package:bakoelku/reusable_widget/alert_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  File? urlImages;
  final validasiUrlImg = false.obs;
  final ImagePicker picker = ImagePicker();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final noTelpController = TextEditingController();

  final nameControllerPedagang = TextEditingController();
  final emailControllerPedagang = TextEditingController();
  final noTelpControllerPedagang = TextEditingController();

  final storageImage = FirebaseStorage.instance;
  CollectionReference collectionReferenceAuth = FirebaseFirestore.instance.collection('auth');

  var uid = Get.arguments;
  
  Future<DocumentSnapshot<Object?>> getSettings() async {
    DocumentReference docRef = firestore.collection("auth").doc(uid);
    return docRef.get();
  }

  ubahDataPedagang(BuildContext context) {
    if (nameControllerPedagang.text.isEmpty) {
      CustomAlertDialogHelp(
        title: "Mohon Maaf", 
        subTitle: "Nama tidak boleh kosong", 
        context: context
      );
    } else if (emailControllerPedagang.text.isEmpty) {
      CustomAlertDialogHelp(
        title: "Mohon Maaf", 
        subTitle: "Email tidak boleh kosong", 
        context: context
      );
    } else if (noTelpControllerPedagang.text.isEmpty) {
      CustomAlertDialogHelp(
        title: "Mohon Maaf", 
        subTitle: "No telp tidak boleh kosong", 
        context: context
      );
    } else {
      collectionReferenceAuth.doc(uid).update({
        'name': nameControllerPedagang.text,
        'email': emailControllerPedagang.text,
        'no_telp': int.parse(noTelpControllerPedagang.text),
      }).then((value) {
        CustomAlertDialogSuccess(
          title: "Berhasil Diperbarui", 
          subTitle: "Akun Berhasil diperbarui", 
          context: context
        );
      }).catchError((onErr) {
        CustomAlertDialogWarning(
          title: "Terjadi Kesalahan", 
          subTitle: onErr, 
          context: context
        );
      });
    }
  }

  ubahDataCustomer(BuildContext context) {
    if (nameController.text.isEmpty) {
      CustomAlertDialogHelp(
        title: "Mohon Maaf", 
        subTitle: "Nama tidak boleh kosong", 
        context: context
      );
    } else if (emailController.text.isEmpty) {
      CustomAlertDialogHelp(
        title: "Mohon Maaf", 
        subTitle: "Email tidak boleh kosong", 
        context: context
      );
    } else if (noTelpController.text.isEmpty) {
      CustomAlertDialogHelp(
        title: "Mohon Maaf", 
        subTitle: "No telp tidak boleh kosong", 
        context: context
      );
    } else {
      collectionReferenceAuth.doc(uid).update({
        'name': nameController.text,
        'email': emailController.text,
        'no_telp': int.parse(noTelpController.text),
      }).then((value) {
        CustomAlertDialogSuccess(
          title: "Berhasil Diperbarui", 
          subTitle: "Akun Berhasil diperbarui", 
          context: context
        );
      }).catchError((onErr) {
        CustomAlertDialogWarning(
          title: "Terjadi Kesalahan", 
          subTitle: onErr, 
          context: context
        );
      });
    }
  }

  Future uploadImageGallery(BuildContext context) async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      urlImages = File(pickerFile.path);
      validasiUrlImg.value = true;
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

  Future uploadImageCamera() async {
    final pickerFile = await picker.pickImage(source: ImageSource.camera);

    if (pickerFile != null) {
      urlImages = File(pickerFile.path);
      validasiUrlImg.value = true;
      // uploadToStorage(namaPedagang, namaGerobak);
    } else {
      // ignore: avoid_print
      print("error Camera");
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
      
      FirebaseFirestore.instance.collection('auth').doc(uid).update({
        'foto_gerobak': FieldValue.arrayUnion([
          urlDownload,
        ])
      });
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


}
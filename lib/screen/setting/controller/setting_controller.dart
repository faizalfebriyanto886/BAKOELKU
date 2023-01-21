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
  final storageImage = FirebaseStorage.instance;

  var uid = Get.arguments;
  
  Future<DocumentSnapshot<Object?>> getSettings() async {
    DocumentReference docRef = firestore.collection("auth").doc(uid);
    return docRef.get();
  }

  ubahDataCustomer(BuildContext context) {
    CollectionReference collectionSettingUpdate = FirebaseFirestore.instance.collection("auth");
    collectionSettingUpdate.doc(uid).update({
      'name': nameController.text,
      'email': emailController.text,
      'no_telp': int.parse(noTelpController.text),
    }).then((value) {
      CustomAlertDialogSuccess(
        title: "Berhasil", 
        subTitle: "Akun Berhasil diupdate", 
        context: context
      );
    });
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
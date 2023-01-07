import 'dart:io';

import 'package:bakoelku/reusable_widget/alert_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  final urlImage = Rxn<File>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final noTelpController = TextEditingController();

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

  imagePickerGallery({required Rxn<File> fileImage}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery
      );

      fileImage.value = File(image!.path);
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }

  imagePickerCamera({required Rxn<File> fileImage}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.camera
      );

      fileImage.value = File(image!.path);
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }

}
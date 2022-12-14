import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  final urlImage = Rxn<File>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var uid = Get.arguments;
  
  Future<DocumentSnapshot<Object?>> getSettings() async {
    DocumentReference docRef = firestore.collection("auth").doc(uid);
    return docRef.get();
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
import 'dart:io';
import 'dart:math';
import 'package:bakoelku/reusable_widget/alert_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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

  final namaMenuAddController = TextEditingController();
  final hargaMenuAddController = TextEditingController();

  final namaMenuUbahController = TextEditingController();
  final hargaMenuUbahController = TextEditingController();

  final storageImage = FirebaseStorage.instance;
  CollectionReference collectionReferenceAuth = FirebaseFirestore.instance.collection('auth');

  // time variable
  TimeOfDay timeBuka = TimeOfDay.now();
  TimeOfDay timeTutup = TimeOfDay.now();
  var validationJamBuka = false.obs;
  var validationJamTutup = false.obs;

  var uid = Get.arguments;
  
  Future<DocumentSnapshot<Object?>> getSettings() async {
    DocumentReference docRef = firestore.collection("auth").doc(uid);
    return docRef.get();
  }

  Stream<DocumentSnapshot<Object?>> updateRealTime() {
    DocumentReference realtime = firestore.collection("auth").doc(uid);
    return realtime.snapshots();
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

  addMenuTofirestore(BuildContext context) {
    if (namaMenuAddController.text.isNotEmpty && hargaMenuAddController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("auth").doc(uid).update({
        'menu': FieldValue.arrayUnion([
          {
            "harga": int.parse(hargaMenuAddController.text),
            "nama": namaMenuAddController.text
          }
        ])
      }).then((value) {
        hargaMenuAddController.clear();
        namaMenuAddController.clear();
        update();
      });
    } else {
      CustomAlertDialogHelp(title: "Mohon Maaf", subTitle: "Terdapat kolom kosong!!", context: context);
      hargaMenuAddController.clear();
      namaMenuAddController.clear();
    } 
  }

  deleteMenuToFirestore(var index) {
    FirebaseFirestore.instance.collection("auth").doc(uid).update({
      'menu': FieldValue.arrayRemove([index])
    });
    update();
  }

  valueOfArray() {
    
  }

  ubahMenuToFirestore() {
    // FirebaseFirestore.instance.collection("auth").doc(uid).update({
    //     'menu': FieldValue.arrayUnion([
    //       {
    //         "harga": int.parse(hargaMenuAddController.text),
    //         "nama": namaMenuAddController.text
    //       }
    //     ])
    //   })
    FirebaseFirestore.instance.collection("auth").doc(uid).update({
      'menu': [
        // 0: "sensor"
      ]
    });
  }

  void selectTimeBuka(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: timeBuka,
    );
    if (newTime != null) {
      timeBuka = newTime;
      validationJamBuka.value = true;
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
      validationJamTutup.value = true;
      update();
    }
    update();
  }

  updateJam(BuildContext context) {
    if (validationJamBuka.value == false || validationJamTutup.value == false) {
      CustomAlertDialogWarning(
        title: "Terjadi Kesalahan", 
        subTitle: "Mohon Penuhi Semua Pembaruan !!!", 
        context: context
      );
    } else {
      FirebaseFirestore.instance.collection("auth").doc(uid).update({
        // ignore: use_build_context_synchronously
        'jam_tutup': timeTutup.format(context).toString(),
        'jam_buka': timeBuka.format(context).toString()
      }).then((value) {
        CustomAlertDialogSuccess(
          title: "Berhasil", 
          subTitle: "Waktu Berhasil di update", 
          context: context
        );
      });
    }
  }
}
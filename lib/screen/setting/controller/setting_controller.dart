import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final dataUser = FirebaseAuth.instance.currentUser;
  CollectionReference getUser = FirebaseFirestore.instance.collection('auth');

  getUserData() {
    getUser.doc('0l6Gsa9X3dqcWGX24t5M').get().then((value) {
      // belum selesai
      print(value.data());
    });
  }
}
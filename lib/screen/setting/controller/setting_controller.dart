import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final dataUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var uid = Get.arguments;
  
  Future<DocumentSnapshot<Object?>> getSettings() async {
    DocumentReference docRef = firestore.collection("auth").doc(uid);
    return docRef.get();
  }
}
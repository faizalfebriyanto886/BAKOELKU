import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final dataUser = FirebaseAuth.instance.currentUser;
  var getUser = FirebaseFirestore.instance.collection('auth').doc('0l6Gsa9X3dqcWGX24t5M').get();

  // @override
  // void onInit() {
  //   // getUserData();
  //   super.onInit();
  // }
  
  // getUserData() async {
  //   var collection = FirebaseFirestore.instance.collection('auth');
  //   var docSnapshot = await collection.doc('0l6Gsa9X3dqcWGX24t5M').get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     var value = data?['name'];
  //     print(value);
  //   }
  // }
}
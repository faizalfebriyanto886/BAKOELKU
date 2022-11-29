import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final dataUser = FirebaseAuth.instance.currentUser;

  data() {
    final dataUser = FirebaseAuth.instance.currentUser;
    print(dataUser!.email);
  }
}
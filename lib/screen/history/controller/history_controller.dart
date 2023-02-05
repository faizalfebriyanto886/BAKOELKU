
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var uidUser = FirebaseAuth.instance.currentUser!.uid;
  List getOrders = [];

  getDataOrderPembeli() {
    FirebaseFirestore.instance.collection('order').where("uid_pembeli", isEqualTo: uidUser).get().then((snapshot) {
      for (var orders in snapshot.docs) {
        getOrders.add(orders.data());
        update();
      }
    });
    update();
  }

  getDataOrderPedagang() {
    FirebaseFirestore.instance.collection('order').where("uid_pedagang", isEqualTo: uidUser).get().then((snapshot) {
      for (var orders in snapshot.docs) {
        getOrders.add(orders.data());
        update();
      }
    });
    update();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotifikasiController extends GetxController {
  final _collectionRef = FirebaseFirestore.instance.collection('notifikasi').orderBy('tanggal', descending: true);

  updateStatusRead(String docID) {
    FirebaseFirestore.instance.collection("notifikasi").doc(docID).update({
      "notifikasi_status": true,
    });
  }

  Future<List> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    List allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }
}
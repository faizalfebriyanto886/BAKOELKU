
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeControllerSelesaiPemesanan extends GetxController { 
  final ulasanController = TextEditingController();
  List dataPembeli = [];
  String namaPembeli = '';
  String alamatPembeli = '';
  int noTelpPembeli = 0;
  RxString rateController = ''.obs;

  @override
  void onInit() {
    getDataPembeli();
    super.onInit();
  }

  Future<DocumentSnapshot<Object?>> getDataUser(String uid) { // get data pedagang pedagang
    DocumentReference docRef = FirebaseFirestore.instance.collection("auth").doc(uid);
    return docRef.get();
  }

  getDataPembeli() {
    var uidPembeli = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('auth').doc(uidPembeli).get().then((value) {
      namaPembeli = value.data()!['name'];
      alamatPembeli = value.data()!['alamat'];
      noTelpPembeli = value.data()!['no_telp'];
      update();
    });
  }

  addDataOrder(
    String namaPedagang, 
    int noTelpPedagang, 
    String alamatPedagang, 
    String namaGerobak, 
    String fotoGerobak,
    String uidPedagang,
  ) {
    var uidPembeli = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("order").add({
      'ulasan': ulasanController.text,
      'nama_pembeli': namaPembeli,
      'noTelp_pembeli': noTelpPembeli,
      'alamat_pembeli': alamatPembeli,
      'nama_pedagang': namaPedagang,
      'noTelp_pedagang': noTelpPedagang,
      'alamat_pedagang': alamatPedagang,
      'nama_gerobak': namaGerobak,
      'foto_gerobak': fotoGerobak,
      'status': "selesai",
      'uid_pembeli': uidPembeli,
      'uid_pedagang': uidPedagang,
      'rate': rateController.value,
    });
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  List<String> imageCarousel = [
    'assets/images/mart-dummy.png',
    'assets/images/mart-dummy.png',
    'assets/images/mart-dummy.png',
  ];
}
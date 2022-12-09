import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Completer<GoogleMapController> controllerCompleter = Completer();
  BitmapDescriptor markericon = BitmapDescriptor.defaultMarker;

  @override
  void onInit() {
    customIconMarker();
    super.onInit();
  }

  void customIconMarker() async {
    await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'assets/icon/marker-pedagang-mark-2.png').then((value) {
      markericon = value;
    });
    update();
  }

  Future<DocumentSnapshot<Object?>> getDataUser(String uid) async {
    DocumentReference docRef = firestore.collection('auth').doc(uid);
    return docRef.get();
  }

  List<String> imageCarousel = [
    'assets/images/mart-dummy.png',
    'assets/images/mart-dummy.png',
    'assets/images/mart-dummy.png',
  ];
}
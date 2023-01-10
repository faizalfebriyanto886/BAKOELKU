import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeControllerDetailPedagang extends GetxController {
  final markers = <Marker>{}.obs;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void onInit() {
    customIconMarker();
    super.onInit();
  }

  void customIconMarker() async {
    await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'assets/icon/marker-pedagang.png').then((value) {
      markerIcon = value;
    });
    update();
  }

  markerPedagang(lang, long) {
    markers.add(
      Marker(
        markerId: const MarkerId("pembeli"),
        position: LatLng(lang, long),
        icon: markerIcon,
        draggable: true,
      )
    );
    update();
  }

  Future<DocumentSnapshot<Object?>> getDataUser(String uid) {
    DocumentReference docRef = FirebaseFirestore.instance.collection("auth").doc(uid);
    return docRef.get();
  }

  List<String> imageCarousel = [
    'assets/images/mart-dummy.png',
    'assets/images/mart-dummy.png',
    'assets/images/mart-dummy.png',
  ];

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
}

import 'package:bakoelku/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeControllerMenujuCustomer extends GetxController {
  // final markers = <Marker>{}.obs;
  Set<Polyline> polylineDestination = {};
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Map<MarkerId, Marker> markersPolyline = {};

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

  Future<DocumentSnapshot<Object?>> getDataUser() {
    DocumentReference docRef = FirebaseFirestore.instance.collection("auth").doc(FirebaseAuth.instance.currentUser!.uid);
    return docRef.get();
  }

  addMarker(LatLng position, String idMarker, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(idMarker);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position
    );
    markersPolyline[markerId] = marker;
    update();
  }

  addPolyline() {
    PolylineId idPolyline = const PolylineId("set Polyline");
    Polyline polyline = Polyline(
      polylineId: idPolyline,
      color: second,
      width: 4,
      points: polylineCoordinates
    );
    polylines[idPolyline] = polyline;
    update();
  }

  setPolyline(LatLng pembeliLatlng, LatLng penjualLatlng) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDr1FkdGTNvnySoBYdm7zZttr6ixPMYbZ8',
      PointLatLng(pembeliLatlng.latitude, pembeliLatlng.longitude),
      PointLatLng(penjualLatlng.latitude, penjualLatlng.longitude),
    );
    
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude)
        );
      }
    }
    addPolyline();
    update();
  }

  List<String> imageCarousel = [
    'assets/images/mart-dummy.png',
    'assets/images/mart-dummy.png',
    'assets/images/mart-dummy.png',
  ];
}
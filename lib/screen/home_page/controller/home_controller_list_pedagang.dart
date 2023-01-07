import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeControllerListPedagang extends GetxController {
  BitmapDescriptor markericon = BitmapDescriptor.defaultMarker;
  CollectionReference pedagangFirestore = FirebaseFirestore.instance.collection("auth");
  // ignore: prefer_collection_literals
  final Set<Marker> markers = Set();

  markpedagang(LatLng posisi) {
    markers.add(Marker(
      markerId: MarkerId("pedagang"),
      position: posisi,
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  Future<QuerySnapshot<Object?>> markPedagangSekitar() async {
    Query<Map<String, dynamic>> markPedagang = FirebaseFirestore.instance.collection("auth").where('role',isEqualTo: 'pedagang');
    return markPedagang.get();
  }
}
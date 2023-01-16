import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../view/home_page_detail_pedagang.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference pedagangFirestore = FirebaseFirestore.instance.collection("auth");
  final Set<Marker> markers = <Marker>{};
  final Completer<GoogleMapController> controllerCompleter = Completer();
  BitmapDescriptor markericon = BitmapDescriptor.defaultMarker;

  @override
  void onInit() {
    customIconMarker();
    markerPedagangSekitar();
    super.onInit();
  }

  void customIconMarker() async {
    await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'assets/icon/marker-pedagang.png').then((value) {
      markericon = value;
    });
    update();
  }
  
   markerPedagangSekitar() async {
    pedagangFirestore.where('role', isEqualTo: 'pedagang').get().then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        GeoPoint latLng = element['latlong'];
        markers.add(
          Marker(
            markerId: MarkerId(element['name']),
            position: LatLng(latLng.latitude, latLng.longitude),
            icon: markericon,
            draggable: true,
            onTap: () async {
              Get.to(() => HomePageDetailPedagang(docId: element['uid']));
            },
          ),
        );
      }
    });
    update();
  }

  markerPembeli(lang, long) {
    markers.add(
      Marker(
        markerId: const MarkerId("pembeli"),
        position: LatLng(lang, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        draggable: true,
        flat: true,
        infoWindow: const InfoWindow(
          title: "Lokasi Anda"
        )
      )
    );
    update();
  }
   
  Future<DocumentSnapshot<Object?>> getDataUser(String uid) async {
    DocumentReference docRef = firestore.collection('auth').doc(uid);
    return docRef.get();
  }

  updateLokasiUser(String uid) async {
  //  CollectionReference userData = FirebaseFirestore.instance.collection("auth");
  //   Position posisi = await getGeoLocationPosition();
  //   userData.doc(uid).update({
  //     'latlong': GeoPoint(posisi.latitude, posisi.longitude)
  //   }).then((value) {
  //     // ignore: avoid_print
  //     print("success");
  //   }).catchError((err) {
  //     // ignore: avoid_print
  //     print(err);
  //   });
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
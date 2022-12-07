import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Completer<GoogleMapController> controllerCompleter = Completer();
  final Set<Marker> markers =  {};
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(-7.315360, 112.797699),
    zoom: 14,
  );
  final LatLng currentPosition = const LatLng(-7.315360, 112.797699);
  Uint8List? marketimages;
  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  
  // void oninit() async {
  //   getMarker();
  //   super.onInit();
  // }

  getMarker() async {
    final Uint8List markIcons = await getImages('assets/icon/point-pedagang.png', 100);
    markers.add(
      Marker(
        markerId: const MarkerId('-7.315360, 98.672226'),
        position: currentPosition,
        icon: BitmapDescriptor.fromBytes(markIcons)
      ),
    );
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
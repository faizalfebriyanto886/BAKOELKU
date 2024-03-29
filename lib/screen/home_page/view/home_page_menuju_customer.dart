import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/screen/home_page/controller/home_controller_menuju_customer.dart';
import 'package:bakoelku/screen/home_page/view/home_page_selesai_pemesanan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../chat/view/chat_page.dart';

class HomePageMenujuCustomer extends StatelessWidget {
  final String docId;
  final LatLng destination;
  final String alamatPedagang;
  final List fotoGerobak;
  final String namaGerobak;
  final String noTelp;
  const HomePageMenujuCustomer({
    required this.docId,
    required this.destination,
    required this.alamatPedagang,
    required this.fotoGerobak,
    required this.namaGerobak,
    required this.noTelp,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeControllerMenujuCustomer());
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getDataUser(), // pembeli
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var dataUser = snapshot.data!.data() as Map<String, dynamic>;
            GeoPoint location = dataUser['latlong'];
            return Stack(
              children: [
                GetBuilder(
                  init: controller,
                  builder: (_) {
                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(location.latitude, location.longitude),
                        zoom: 14
                      ),
                      mapType: MapType.normal,
                      markers: Set<Marker>.of(controller.markersPolyline.values),
                      polylines: Set<Polyline>.of(controller.polylines.values),
                      onMapCreated: (GoogleMapController mapController) {
                        controller.addMarker(LatLng(location.latitude, location.longitude), "Pembeli", BitmapDescriptor.defaultMarkerWithHue(90));
                        controller.addMarker(LatLng(destination.latitude, destination.longitude), "Penjual", controller.markerIcon);
                        controller.setPolyline(LatLng(location.latitude, location.longitude), LatLng(destination.latitude, destination.longitude));
                        controller.addPolyline();
                      },
                    );
                  }
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // for Detail menu
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            CarouselSlider(
                              items: fotoGerobak.map((value) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(color: primary)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(value),
                                )
                              )).toList(),
                              options: CarouselOptions(
                                height: 90,
                                aspectRatio: 16/9,
                                viewportFraction: 0.4,
                                initialPage: 0,
                                enlargeCenterPage: true,
                                autoPlay: false, // jika sudah maka autoplay bisa di aktifkan
                                autoPlayAnimationDuration: const Duration(seconds: 5),
                                autoPlayCurve: Curves.bounceIn,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        namaGerobak,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black
                                        ),
                                      ),
                                      Text(
                                        "Jarak : 20 Meter", 
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: greyColor
                                        ),
                                      )
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: second,
                                                ),
                                                child: Container(
                                                  height: 5,
                                                  width: 5,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(alamatPedagang, style: TextStyle(fontSize: 12, color: greyColor),)
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 6),
                                            child: DottedLine(
                                              direction: Axis.vertical,
                                              lineLength: 35,
                                              lineThickness: 2.0,
                                              dashColor: second,
                                              dashRadius: 5,
                                              dashLength: 5,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: second,
                                                ),
                                                child: Container(
                                                  height: 5,
                                                  width: 5,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text("Lokasi Anda", style: TextStyle(fontSize: 12, color: greyColor),)
                                            ],
                                          )
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              FlutterPhoneDirectCaller.callNumber('0$noTelp');
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: primary,
                                              radius: 18,
                                              child: const Icon(
                                                Icons.phone,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () => Get.to(() => const ChatPageView()),
                                            child: CircleAvatar(
                                              backgroundColor: primary,
                                              radius: 18,
                                              child: const Icon(
                                                Icons.messenger,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector( // button cancel
                                onTap: () => Get.back(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: danger,
                                    ),
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Batalkan Rute",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      ],
                                    )
                                  ),
                                ),
                                GestureDetector( // button Sampai Tujuan
                                  onTap: () => Get.offAll(() => HomepageSelesaiPemesanan(docId: docId,)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: second,
                                    ),
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Sampai Tujuan",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      ],
                                    )
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ]
            );
          }
          return const CustomLoadingIndicator();
        }
      ),
    );
  }

  Widget buildMaps() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/maps_screenshot.png'),
          fit: BoxFit.cover
        )
      ),
    );
  }
}
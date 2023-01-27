import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/screen/chat/view/chat_page.dart';
import 'package:bakoelku/screen/home_page/controller/home_controller.dart';
import 'package:bakoelku/screen/home_page/view/home_page_detail_pedagang.dart';
import 'package:bakoelku/screen/setting/view/setting_page_pedagang.dart';
import 'package:bakoelku/screen/setting/view/setting_page_pembeli.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  final String docId;
  final controller = Get.put(HomeController());
  HomePage({ required this.docId, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getDataUser(docId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var dataUser = snapshot.data!.data() as Map<String, dynamic>;
            GeoPoint location = dataUser['latlong'];
            controller.updateLokasiUser(docId);
            return Stack(
              children: [
                GetBuilder(
                  init: controller,
                  builder: (_) {
                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(location.latitude, location.longitude),
                        zoom: 14, 
                      ),
                      mapType: MapType.normal,
                      markers: dataUser['role'] == 'pembeli' ? controller.markersPembeli : controller.markersPedagang,
                      onMapCreated: (GoogleMapController homecontroller) {
                        // controller.controllerCompleter.complete(homecontroller);
                        controller.markerPedagangSekitar();
                        controller.markerPembeli(location.latitude, location.longitude);
                        controller.markerPedagang(location.latitude, location.longitude);
                      },
                    );
                  }
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dataUser['role'] == 'pembeli'
                    ? Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const SettingPageView(), arguments: docId);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primary),
                                color: Colors.white
                              ),
                              child: Icon(
                                Icons.settings,
                                color: primary,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.65,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(9),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1, color: primary),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1, color: primary),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1, color: primary),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(width: 1,)
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(width: 1,color: Colors.black)
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(width: 1,color: primary)
                                ),
                                hintText: "Mencari Pedagang kesukaanmu...",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFB3B1B1)
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() => HomePageDetailPedagang(docId: docId)),
                            child: Container(
                              padding: const EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primary),
                                color: Colors.white
                              ),
                              child: Icon(
                                Icons.search,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : const SizedBox(),
                    // for dashboard
                    dataUser['role'] == 'pembeli' 
                    ? dashboardPembeli(location) 
                    : dashboardPedagang(
                      dataUser['nama_gerobak'], 
                      dataUser['alamat'], 
                      dataUser['foto_gerobak']
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
  
  dashboardPembeli(GeoPoint koordinat) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Image.asset("assets/images/logo_bakoelku.png", height: 150),
            const SizedBox(height: 15),
            Text(
              "Cari makanan yang kamu suka", 
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500, 
                color: primary
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  dashboardPedagang(String namaGerobak, String alamat, List fotoGerobak) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fotoGerobak.isNotEmpty
            ? CarouselSlider(
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
            ) 
            : const SizedBox(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaGerobak,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      alamat,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: primary,
                      radius: 18,
                      child: const Icon(
                        Iconsax.notification5,
                        color: Colors.white,
                        size: 18,
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
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => SettingPagePedagang(), arguments: docId);
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primary,
                      ),
                      child: const Text(
                        "Pengaturan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primary,
                    ),
                    child: const Text(
                      "Atur Menu",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
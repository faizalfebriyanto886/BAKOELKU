import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/screen/home_page/view/home_page_menuju_customer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../chat/view/chat_page.dart';
import '../controller/home_controller_detail_pedagang.dart';

class HomePageDetailPedagang extends StatelessWidget {
  final String docId;
  const HomePageDetailPedagang({
    required this.docId,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeControllerDetailPedagang());
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getDataUser(docId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var dataUser = snapshot.data!.data() as Map<String, dynamic>;
            GeoPoint location = dataUser['latlong'];
            List fotoGerobak = dataUser['foto_gerobak'];
            List menu = dataUser['menu'];
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
                      markers: controller.markers,
                      onMapCreated: (GoogleMapController mapController) {
                        controller.markerPedagang(location.latitude, location.longitude);
                      },
                    );
                  }
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70, left: 20),
                      child: GestureDetector(
                        onTap:()=> Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primary),
                            color: Colors.white
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: primary,
                          ),
                        ),
                      ),
                    ),

                    // for Detail menu
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                                      child: Image.network(value, gaplessPlayback: true)
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
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataUser['nama_gerobak'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        dataUser['alamat'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () => Get.to(() => const ChatPageView(), arguments: docId),
                                                child: CircleAvatar(
                                                  backgroundColor: primary,
                                                  radius: 22,
                                                  child: const Icon(
                                                    Icons.messenger,
                                                    color: Colors.white,
                                                    size: 22,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () async {
                                                  FlutterPhoneDirectCaller.callNumber('0${dataUser['no_telp']}');
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: primary,
                                                  radius: 22,
                                                  child: const Icon(
                                                    Icons.phone,
                                                    color: Colors.white,
                                                    size: 22,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                              border: Border.all(color: primary)
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Buka : ${dataUser['jam_buka']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primary),),
                                                const SizedBox(height: 10),
                                                Text("Tutup : ${dataUser['jam_tutup']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primary),)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        bottomSheetMenu(menu);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: primary
                                        ),
                                        child: const Text(
                                          "Lihat Menu",
                                            style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500
                                            ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector( // button Next
                                      onTap: () {
                                        Get.to(() => HomePageMenujuCustomer(
                                          docId: docId, 
                                          destination: LatLng(location.latitude, location.longitude), 
                                          alamatPedagang: dataUser['alamat'], 
                                          fotoGerobak: fotoGerobak,
                                          namaGerobak: dataUser['nama_gerobak'],
                                          noTelp: dataUser['no_telp'].toString(),
                                          ),
                                        );
                                        controller.tambahNotifikasi(docId, dataUser['name']);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: primary,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text(
                                              "Menuju Lokasi",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Icon(
                                              Icons.keyboard_arrow_right_outlined,
                                              color: Colors.white,
                                              size: 28,
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
                        ],
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

  bottomSheetMenu(List menuList) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
           color: Colors.white
        ),
        child: ListView.separated(
          itemCount: menuList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: primary)
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/icon/icon_menu_2.png', height: 50)
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(menuList[index]['nama'], style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),),
                      const SizedBox(height: 10),
                      Text(menuList[index]['harga'].toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.green),)
                    ],
                  )
                ],
              ),
            );
          },
        ),
      )
    );
  }
}
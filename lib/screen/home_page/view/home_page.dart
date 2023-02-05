import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/screen/history/view/history_page.dart';
import 'package:bakoelku/screen/history/view/history_page_pedagang.dart';
import 'package:bakoelku/screen/home_page/controller/home_controller.dart';
import 'package:bakoelku/screen/home_page/view/home_page_detail_pedagang.dart';
import 'package:bakoelku/screen/main_page/view/main_page_view.dart';
import 'package:bakoelku/screen/notifikasi/view/notifikasi_page.dart';
import 'package:bakoelku/screen/setting/view/setting_page_menu_pedagang.dart';
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
                    const SizedBox(),

                    // for dashboard
                    dataUser['role'] == 'pembeli' 
                    ? dashboardPembeli(location, dataUser) 
                    : dashboardPedagang(
                      dataUser['nama_gerobak'], 
                      dataUser['alamat'], 
                      dataUser['foto_gerobak'],
                      dataUser['no_telp'].toString(),
                      context
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
  
  dashboardPembeli(GeoPoint koordinat, Map dataFavorit) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width * 0.65,
                    child: TextField(
                      controller: controller.fieldSearchController,
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
                      onChanged: (value) {
                        controller.valueSearchController.value = value;
                        controller.update();
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.fieldSearchController.text.isNotEmpty) {
                        bottomSheetSearch();
                        controller.fieldSearchController.clear();
                        controller.pedagangSearch.clear();
                      } else {
                        const SizedBox();
                      }
                    },
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
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              bottomSheetTerpopular();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primary),
                                color: Colors.white
                              ),
                              child: Image.asset("assets/icon/award_menu.png", height: 40,),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text("Terpopular", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primary),
                              color: Colors.white
                            ),
                            child: Image.asset("assets/icon/location_menu.png", height: 40,),
                          ),
                          const SizedBox(height: 10),
                          const Text("Terdekat", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const SettingPageView(), arguments: docId);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primary),
                                color: Colors.white
                              ),
                              child: Image.asset("assets/icon/settings.png", height: 40,),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text("Pengaturan", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const HistoryPage());
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primary),
                                color: Colors.white
                              ),
                              child: Image.asset("assets/icon/riwayat_pesanan.png", height: 40,),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text("Riwayat", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  dashboardPedagang(String namaGerobak, String alamat, List fotoGerobak, String noTelp, BuildContext context) {
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
              items: fotoGerobak.map((value) => GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration:  const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)
                        )
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.hapusFotoGerobak(value, docId, context);
                              Get.back();
                              Get.to(() => const MainPageView());
                            },
                            child: Container(
                              height: 40,
                              width: Get.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: danger
                              ),
                              child: const Text("Hapus", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          )
                        ],
                      ),
                    )
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: primary)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(value),
                  )
                ),
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
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const NotifikasiPage());
                      },
                      child: CircleAvatar(
                        backgroundColor: primary,
                        radius: 18,
                        child: const Icon(
                          Iconsax.notification5,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const HistoryPagePedagang());
                      },
                      child: CircleAvatar(
                        backgroundColor: primary,
                        radius: 18,
                        child: const Icon(
                          Iconsax.task_square5,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () => Get.to(() => const ChatPagePedagangView()),
                    //   child: CircleAvatar(
                    //     backgroundColor: primary,
                    //     radius: 18,
                    //     child: const Icon(
                    //       Icons.messenger,
                    //       color: Colors.white,
                    //       size: 18,
                    //     ),
                    //   ),
                    // ),
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
                  onTap: () {
                    Get.to(() => SettingPageMenuPedagang(), arguments: docId);
                  },
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

  bottomSheetTerpopular() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Terpopuler", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.pedagangFavorit.length,
                separatorBuilder: (context, index) => const SizedBox(height: 15), 
                itemBuilder: (context, index) {
                  List fotoPedagang = controller.pedagangFavorit[index]['foto_gerobak'];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => HomePageDetailPedagang(docId: controller.pedagangFavorit[index]['uid']));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primary)
                      ),
                      child: Row(
                        children: [
                          Image.network(fotoPedagang[0] , height: 50, width: 50,),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.pedagangFavorit[index]['nama_gerobak'], style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),),
                              const SizedBox(height: 5),
                              Row(
                                children: const [
                                  Icon(Icons.star, color: Colors.amber, size: 18,),
                                  SizedBox(width: 5),
                                  Text("5", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(controller.pedagangFavorit[index]['alamat'], style: TextStyle(color: greyColor, fontSize: 12, fontWeight: FontWeight.w500),)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }, 
              )
            ],
          ),
        ),
      )
    );
  }

  bottomSheetSearch() {
    Get.bottomSheet(
      GetBuilder<HomeController>(
        init: controller.searchPedagang(),
        builder: (_) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              )
            ),
            child: ListView.separated(
              itemCount: controller.pedagangSearch.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                if (controller.valueSearchController.value.isEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Get.off(HomePageDetailPedagang(docId: controller.pedagangSearch[index]['uid']));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primary),
                        color: Colors.white
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: primary)
                            ),
                            child: Image.asset("assets/icon/icon_menu_2.png", height: 50, width: 50),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(controller.pedagangSearch[index]['nama_gerobak'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Icon(Iconsax.location5, color: greyColor, size: 16),
                                    const SizedBox(width: 7),
                                    Text(controller.pedagangSearch[index]['alamat'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: greyColor),),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Icon(Iconsax.call5, color: greyColor, size: 16),
                                    const SizedBox(width: 7),
                                    Text("0${controller.pedagangSearch[index]['no_telp'].toString()}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: greyColor),),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primary),
                              color: Colors.white
                            ),
                            child: Text("Buka : ${controller.pedagangSearch[index]['jam_buka']}", style: TextStyle(color: primary, fontSize: 12, fontWeight: FontWeight.normal),),
                          )
                        ],
                      ),
                    ),
                  );
                }
                if (controller.pedagangSearch[index]['nama_gerobak'].toString().toLowerCase().startsWith(controller.valueSearchController.value.toLowerCase())) {
                  return GestureDetector(
                    onTap: () {
                      Get.off(HomePageDetailPedagang(docId: controller.pedagangSearch[index]['uid']));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primary),
                        color: Colors.white
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: primary)
                            ),
                            child: Image.asset("assets/icon/icon_menu_2.png", height: 50, width: 50),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.pedagangSearch[index]['nama_gerobak'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Icon(Iconsax.location5, color: greyColor, size: 16),
                                    const SizedBox(width: 7),
                                    Text(controller.pedagangSearch[index]['alamat'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: greyColor),),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Icon(Iconsax.call5, color: greyColor, size: 16),
                                    const SizedBox(width: 7),
                                    Text("0${controller.pedagangSearch[index]['no_telp'].toString()}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: greyColor),),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primary),
                              color: Colors.white
                            ),
                            child: Text("Buka : ${controller.pedagangSearch[index]['jam_buka']}", style: TextStyle(color: primary, fontSize: 12, fontWeight: FontWeight.normal),),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              }, 
            ),
          );
        }
      )
    );
  }
}
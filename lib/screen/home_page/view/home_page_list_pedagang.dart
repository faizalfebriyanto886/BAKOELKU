import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/screen/home_page/controller/home_controller_list_pedagang.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../colors.dart';

class HomePageListPedagang extends StatelessWidget {
  final GeoPoint latlong;
  const HomePageListPedagang({
    Key? key,
    required this.latlong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeControllerListPedagang());
    return Scaffold(
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: controller.markPedagangSekitar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var allData = snapshot.data!.docs;
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(latlong.latitude, latlong.longitude),
                    zoom: 14,
                  ),
                  mapType: MapType.normal,
                  // markers: controller.markpedagang(),
                  onMapCreated: (controllerOnMap) {
                    
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Get.to(() => const SettingPageView(), arguments: docId);
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
                            onTap: () {},
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

                    // for Detail menu
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: Get.width,
                              child: ListView.builder(
                                itemCount: allData.length,
                                itemBuilder: (context, index) {
                                  return Text(allData[index]['latlong'].toString());
                                },
                              ),
                            )
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Image.asset("assets/images/mart-dummy.png", height: 90,),
                            // ),
                            // const SizedBox(height: 20),
                            // Text("Sedang Mencari", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: primary),)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          }
          return const CustomLoadingIndicator();
        }
      ),
    );
  }
}
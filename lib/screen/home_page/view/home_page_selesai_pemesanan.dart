import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/screen/home_page/controller/home_controller_selesai_pemesanan.dart';
import 'package:bakoelku/screen/main_page/view/main_page_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import '../../../colors.dart';

class HomepageSelesaiPemesanan extends StatelessWidget {
  final String docId;
  const HomepageSelesaiPemesanan({
    Key? key,
    required this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeControllerSelesaiPemesanan());
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getDataUser(docId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var dataUser = snapshot.data!.data() as Map<String, dynamic>;
            GeoPoint location = dataUser['latlong'];
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(location.latitude, location.longitude),
                    zoom: 14
                  ),
                  mapType: MapType.normal,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),

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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: primary)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(dataUser['foto_gerobak'][0], height: 70,),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(dataUser['nama_gerobak'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),),
                            const SizedBox(height: 10),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.rateController.value = 'kurang';
                                      controller.update();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: danger),
                                        borderRadius: BorderRadius.circular(10),
                                        color: controller.rateController.value == 'kurang' ? danger.withOpacity(0.2) : Colors.white
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Iconsax.emoji_sad5, color: danger, size: 16,),
                                          const SizedBox(width: 5),
                                          Text("Kurang", style: TextStyle(color: danger, fontSize: 14, fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.rateController.value = 'cukup';
                                      controller.update();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.amber),
                                        borderRadius: BorderRadius.circular(10),
                                        color: controller.rateController.value == 'cukup' ? Colors.amber.withOpacity(0.2) : Colors.white
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Iconsax.emoji_normal5, color: Colors.amber, size: 16,),
                                          SizedBox(width: 5),
                                          Text("Cukup", style: TextStyle(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.rateController.value = 'memuaskan';
                                      controller.update();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: primary),
                                        borderRadius: BorderRadius.circular(10),
                                        color: controller.rateController.value == 'memuaskan' ? primary.withOpacity(0.2) : Colors.white
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Iconsax.emoji_happy5, color: primary, size: 16,),
                                          const SizedBox(width: 5),
                                          Text("Memuaskan", style: TextStyle(color: primary, fontSize: 14, fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: controller.ulasanController,
                              minLines: 5,
                              maxLines: 7,
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
                                hintText: "Ketik Ulasan",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFB3B1B1)
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                controller.addDataOrder(
                                  dataUser['name'], 
                                  dataUser['no_telp'], 
                                  dataUser['alamat'], 
                                  dataUser['nama_gerobak'], 
                                  dataUser['foto_gerobak'][0].toString(),
                                  dataUser['uid'],
                                );
                                controller.ulasanController.clear();
                                 Get.offAll(() => const MainPageView());
                              },
                              child: Container(
                                height: 40,
                                width: Get.width * 0.7,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: primary,
                                ),
                                child: const Text(
                                  "Selesai",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ),
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
}
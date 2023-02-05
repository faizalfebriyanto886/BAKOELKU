import 'package:bakoelku/colors.dart';
import 'package:bakoelku/reusable_widget/custom_loading_indicator.dart';
import 'package:bakoelku/reusable_widget/custom_text_field.dart';
import 'package:bakoelku/screen/setting/controller/setting_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../main_page/view/main_page_view.dart';

class SettingPagePedagang extends StatelessWidget {
  final controller = Get.put(SettingController());
  SettingPagePedagang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Ubah Data", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),),
        leading: IconButton(
          onPressed: () {
            Get.off(() => const MainPageView());
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getSettings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: primary),
                            color: Colors.white
                          ),
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/foto-profile.png"),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                            const SizedBox(height: 5),
                            Text(data['email'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: primary)
                              ),
                              child: Text(data['alamat'], style: TextStyle(color: primary, fontSize: 12, fontWeight: FontWeight.w500),),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primary.withOpacity(0.15),
                            border: Border.all(
                              color: primary
                            )
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      bottomSheetUploadImage(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: primary),
                                        color: Colors.white
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Image.asset("assets/icon/upload-image.png", height: 40, width: 40),
                                          const SizedBox(width: 20),
                                          Text(
                                            "Tambahkan Gambar", 
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: hintTextColor
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      controller.uploadToStorage(data['name'], data['nama_gerobak'], context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: primary),
                                        color: Colors.white
                                      ),
                                      child: Icon(Icons.file_upload_outlined, color: primary,),
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primary.withOpacity(0.15),
                            border: Border.all(
                              color: primary
                            )
                          ),
                          child: Column(
                            children: [
                              CustomTextFieldSettingWidget(
                                controller: controller.nameControllerPedagang,
                                colorsBorder: primary,
                                widthSized: Get.width, 
                                hintText: data['name'], 
                                prefixText: "Ubah Nama"
                              ),
                              const SizedBox(height: 15),
                              CustomTextFieldSettingWidget(
                                controller: controller.emailControllerPedagang,
                                colorsBorder: primary, 
                                widthSized: Get.width, 
                                hintText: data['email'], 
                                prefixText: "Ubah Email"
                              ),
                              const SizedBox(height: 15),
                              CustomTextFieldSettingWidget(
                                controller: controller.noTelpControllerPedagang,
                                colorsBorder: primary,
                                widthSized: Get.width, 
                                hintText: data['no_telp'].toString(), 
                                prefixText: "Ubah No Telp",
                                textInputType: TextInputType.number,
                                textInputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'^0+'), //users can't type 0 at 1st position
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {
                                  controller.ubahDataPedagang(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primary
                                  ),
                                  child: const Text("Simpan", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GetBuilder(
                      init: controller,
                      builder: (_) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primary.withOpacity(0.15),
                            border: Border.all(
                              color: primary
                            )
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.selectTimeBuka(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: primary),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Jam Buka",
                                        style: TextStyle(
                                          color: primary,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        controller.validationJamBuka.value == false
                                        ? data['jam_buka']
                                        : controller.timeBuka.format(context),
                                        style: TextStyle(
                                          color: greyColor,
                                          fontSize: 14
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {
                                  controller.selectTimeTutup(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: primary),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Jam Tutup",
                                        style: TextStyle(
                                          color: primary,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        controller.validationJamTutup.value == false
                                        ? data['jam_tutup']
                                        : controller.timeTutup.format(context),
                                        style: TextStyle(
                                          color: greyColor,
                                          fontSize: 14
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {
                                  controller.updateJam(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primary
                                  ),
                                  child: const Text("Tambahkan", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Get.to(() => const MainPageView());
                        controller.update();
                      },
                      child: Container(
                        height: 40,
                        width: Get.width * 0.7,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: danger,
                        ),
                        child: const Text(
                          "Log Out", 
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 14, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const CustomLoadingIndicator();
        }
      ),
    );
  }

  bottomSheetUploadImage(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                controller.uploadImageCamera();
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: primary
                ),
                child: const Text("Kamera", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                controller.uploadImageGallery(context);
                Get.back();
              },
              child: Container(
                height: 50,
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: primary
                ),
                child: const Text("Gallery", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
              ),
            ),
          ],
        ),
      )
    );
  }
}